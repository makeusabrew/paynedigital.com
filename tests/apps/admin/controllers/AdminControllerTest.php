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

    public function testAddActionShowsCorrectContent() {
        $this->doValidLogin();

        $this->request->dispatch("/admin/posts/add");
        $this->assertBodyHasContents("Save");
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
}
