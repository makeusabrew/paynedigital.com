<?php

class AdminControllerTest extends PHPUnitTestController {
    protected static $fixture_file = "pd_clean";

    protected function doLogin($username, $password, $reset = true) {
        $this->request->setMethod("POST")->setParams(array(
            "email"    => $username,
            "password" => $password,
        ))->dispatch("/admin/login");

        if ($reset === true) {
            $this->request->reset();
        }
    }

    protected function doValidLogin($reset = true) {
        $this->doLogin("test@example.com", "t3stp4ss", $reset);
    }

    public function testAddPostActionRedirectsToLoginWhenNotAuthed() {
        $this->request->dispatch("/admin/posts/add");
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/admin/login");
    }

    public function testInvalidLoginShowsErrorOnLoginPage() {
        $this->request->setMethod("POST")->setParams(array(
            "email" => "invalid@user.com",
            "password" => "invalid",
        ))->dispatch("/admin/login");

        $this->assertBodyHasContents("Invalid login details");
    }

    public function testLoginActionRedirectsToAdminOverviewWithValidDetails() {
        $this->doValidLogin(false);
        
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/admin");
    }

    public function testLoginActionAfterAuthedRedirectsToAdmin() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/login");
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/admin");
    }

    public function testIndexActionWelcomesUser() {
        $this->doValidLogin();

        $this->request->dispatch("/admin");
        $this->assertBodyHasContents("Hi <strong>Test</strong>");
    }

    public function testEditActionRedirectsUserWhoDoesNotOwnPost() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/posts/edit/3");
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/admin");
    }

    public function testEditActionShowsCorrectContentWhenUserOwnsPost() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/posts/edit/1");
        $this->assertBodyHasContents("This is simply a test post");
        $this->assertBodyHasContents("Save");
    }

    public function testEditActionShowsRelevantErrorsWithInvalidData() {
        $this->doValidLogin();
        $this->request->setMethod("POST")
            ->setParams(array())
            ->dispatch("/admin/posts/edit/1");

        $this->assertBodyHasContents("title is required");
        $this->assertBodyHasContents("url is required");
        $this->assertBodyHasContents("published is required");
        $this->assertBodyHasContents("content is required");
    }

    public function testAddActionShowsCorrectContent() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/posts/add");
        $this->assertBodyHasContents("Save");
    }

    public function testAddActionShowsRelevantErrorsWithInvalidData() {
        $this->doValidLogin();
        $this->request->setMethod("POST")
            ->setParams(array())
            ->dispatch("/admin/posts/add");

        $this->assertBodyHasContents("title is required");
        $this->assertBodyHasContents("url is required");
        $this->assertBodyHasContents("published is required");
        $this->assertBodyHasContents("content is required");
    }

    public function testAddActionRedirectsAfterSuccessfulRequest() {
        $this->doValidLogin();
        $this->request->setMethod("POST")
            ->setParams(array(
                'title' => 'My Test Post',
                'url' => 'my-test-post',
                'published' => '01/01/11 11:00',
                'content' => 'This is a test post',
            ))
            ->dispatch("/admin/posts/add");

        $this->assertRedirect(true);
        $this->assertRedirectUrl("/admin");

        $this->request->reset();
        $this->request->dispatch("/admin");
        $this->assertBodyHasContents("Post created");
    }

    public function testGenerateBurnLinkActionRedirectsUserWhoDoesNotOwnPost() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/posts/edit/3/generate-burn-link");
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/admin");
    }

    public function testGenerateBurnLinkActionShowsCorrectContentWhenUserOwnsPost() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/posts/edit/1/generate-burn-link");

        $this->assertBodyHasContents("Link: ");
    }

    public function testLogoutActionRemovesUserAuth() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/logout");
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/admin/login");

        $this->request->reset();

        $this->request->dispatch("/admin");
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/admin/login");
    }

    public function testCommentsCountIsVisibleFromAdminIndexPage() {
        $this->doLogin("another.test@example.com", "t3stp4ss");

        $this->request->dispatch("/admin");

        // this is extremely tenuous. A selenium test would be better...
        $this->assertBodyHasContentsInOrder("Comments");
        $this->assertBodyHasContentsInOrder("2 (1)");
        $this->assertBodyHasContentsInOrder("0 (1)");
        $this->assertBodyHasContentsInOrder("0 (0)");
    }

    public function testCommentsLinkShowsAllComments() {
        $this->doLogin("another.test@example.com", "t3stp4ss");

        $this->request->dispatch("/admin/posts/3/comments");

        $this->assertBodyHasContentsInOrder("Test Person 2");
        $this->assertBodyHasContentsInOrder("Test User 1");
        $this->assertBodyHasContentsInOrder("Another Tester");
    }

    public function testHeadBlockTextareaIsVisibleFromEditPostPage() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/posts/add");

        $this->assertBodyHasContents("Head Block");
        $this->assertBodyHasContents("Script Block");
    }

    public function testEmailIsSentWhenCommentApprovedWithAppropriateNotificationPreference() {
        $this->doLogin("another.test@example.com", "t3stp4ss");

        TestEmailHandler::resetSentEmails();

        $this->request->setMethod("POST")->setParams(array(
            "approved" => "1",
        ))->dispatch("/admin/posts/3/comments/edit/3");

        $emails = TestEmailHandler::getSentEmails();
        $this->assertEquals(3, count($emails)); // 1 to comment author, 2 to others subscribed
        $this->assertEquals('Your comment has been approved', $emails[0]['subject']);
        $this->assertEquals('Another Tester <test5@example.com>', $emails[0]['to']);
        $this->assertEquals('noreply@paynedigital.com', $emails[0]['from']);
        $this->assertTrue((strpos($emails[0]['body'], "http://paynedigital.test/2011/09/another-test-post") !== false));
    }

    public function testEmailNotIsSentWhenCommentApprovedWithAppropriateNotificationPreference() {
        $this->doValidLogin();

        TestEmailHandler::resetSentEmails();

        $this->request->setMethod("POST")->setParams(array(
            "approved" => "1",
        ))->dispatch("/admin/posts/1/comments/edit/4");

        $emails = TestEmailHandler::getSentEmails();
        $this->assertEquals(0, count($emails));
    }

    public function testEmailsSentToUsersWithAppropriatePreferenceWhenCommentApproved() {
        self::loadFixture();

        $this->doLogin("another.test@example.com", "t3stp4ss");

        TestEmailHandler::resetSentEmails();

        $this->request->setMethod("POST")->setParams(array(
            "approved" => "1",
        ))->dispatch("/admin/posts/3/comments/edit/3");

        $emails = TestEmailHandler::getSentEmails();
        $this->assertEquals(3, count($emails));
        $this->assertEquals('A new comment has been added', $emails[1]['subject']);
        $this->assertEquals('Test Person 2 <test@example.com>', $emails[1]['to']);

        $this->assertEquals('A new comment has been added', $emails[2]['subject']);
        $this->assertEquals('Test User 1 <test@example.com>', $emails[2]['to']);
    }

    public function testNotificationEmailsRespectSiteBaseHrefSetting() {
        self::loadFixture();

        $originalSettings = Settings::getSettings();
        $settings = $originalSettings;
        $settings['site']['base_href'] = 'http://fake.domain/';
        Settings::setFromArray($settings);

        $this->doLogin("another.test@example.com", "t3stp4ss");

        TestEmailHandler::resetSentEmails();

        $this->request->setMethod("POST")->setParams(array(
            "approved" => "1",
        ))->dispatch("/admin/posts/3/comments/edit/3");

        $emails = TestEmailHandler::getSentEmails();

        $this->assertTrue((strpos($emails[0]['body'], "http://fake.domain/2011/09/another-test-post") !== false));
        $this->assertTrue((strpos($emails[1]['body'], "http://fake.domain/2011/09/another-test-post") !== false));
        $this->assertTrue((strpos($emails[1]['body'], "http://fake.domain/comment-unsubscribe/") !== false));
        $this->assertTrue((strpos($emails[2]['body'], "http://fake.domain/2011/09/another-test-post") !== false));
        $this->assertTrue((strpos($emails[2]['body'], "http://fake.domain/comment-unsubscribe/") !== false));

        Settings::setFromArray($originalSettings);
    }
}
