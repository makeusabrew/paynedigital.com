<?php

class BlogControllerTest extends PHPUnitTestController {
    protected static $fixture_file = "pd_clean";

    public function testHomepageDoesNotShowDraftPosts() {
        $this->request->dispatch("/");
        $this->assertBodyDoesNotHaveContents("This post hasn't been published");
    }

    public function testHomepageDoesNotShowDeletedPosts() {
        $this->request->dispatch("/");
        $this->assertBodyDoesNotHaveContents("This Post Has Been Deleted");
    }

    public function testDraftUrlReturnsErrorResponse() {
        try {
            $this->request->dispatch("/2010/01/not-published-yet");
        } catch (CoreException $e) {
            $this->assertEquals(CoreException::URL_NOT_FOUND, $e->getCode());
            return;
        }
        $this->fail("Expected exception not raised");
    }

    public function testDeletedUrlReturnsErrorResponse() {
        try {
            $this->request->dispatch("/2011/09/this-post-has-been-deleted");
        } catch (CoreException $e) {
            $this->assertEquals(CoreException::URL_NOT_FOUND, $e->getCode());
            return;
        }
        $this->fail("Expected exception not raised");
    }

    public function testCommentFormWithValidData() {
        $this->request->setMethod("POST")->setParams(array(
            "name" => "Test Person",
            "email" => "test@example.com",
            "content" => "This is a test message",
        ))->dispatch("/2011/09/another-test-post/comment");

        $this->assertRedirect(true);
        $this->assertRedirectUrl("/2011/09/another-test-post/comment/thanks#comments");
        $this->request->reset();

        $this->request->dispatch("/2011/09/another-test-post/comment/thanks");
        $this->assertBodyHasContents("<strong>Thanks!</strong> Your comment has been submitted and will be reviewed shortly.");
    }

    public function testCommentFormWithNoData() {
        $this->request->setMethod("POST")->setParams(array(
            "name" => "",
            "email" => "",
            "content" => "",
        ))->dispatch("/2011/09/another-test-post/comment");

        $this->assertBodyHasContents("Email Address is required");
        $this->assertBodyHasContents("Comment is required");
    }

    public function testCommentFormWithInvalidEmail() {
        $this->request->setMethod("POST")->setParams(array(
            "name" => "",
            "email" => "email@",
            "content" => "",
        ))->dispatch("/2011/09/another-test-post/comment");

        $this->assertBodyHasContents("Email Address is not a valid email address");
    }

    public function testCommentFormWithHoneypotFieldFilledIn() {
        $this->request->setMethod("POST")->setParams(array(
            "name" => "Test Person",
            "email" => "test@example.com",
            "content" => "This is a test message",
            "details" => "foo",
        ))->dispatch("/2011/09/another-test-post/comment");

        $this->assertBodyHasContents("Please do not fill in the details field");
    }

    public function testCommentFormWithGetRequest() {
        try {
            $this->request->dispatch("/2011/09/another-test-post/comment");
        } catch (CoreException $e) {
            $this->assertEquals(CoreException::URL_NOT_FOUND, $e->getCode());
            return;
        }
        $this->fail("Expected exception not raised");
    }

    public function testCommentThanksPageWithoutCompletingCommentForm() {
        $this->request->dispatch("/2011/09/another-test-post/comment/thanks");
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/");
    }

    public function testTagSearch() {
        $this->request->dispatch("/tag/test");

        $this->assertBodyHasContents("Another Test Post");
        $this->assertBodyHasContents("This Is A Test Post");

        $this->assertBodyDoesNotHaveContents("This post hasn't been published");
        $this->assertBodyDoesNotHaveContents("This Post Has Been Deleted");

        $this->request->reset();

        $this->request->dispatch("/tag/php");

        $this->assertBodyHasContents("Another Test Post");

        $this->assertBodyDoesNotHaveContents("This Is A Test Post");
        $this->assertBodyDoesNotHaveContents("This post hasn't been published");
        $this->assertBodyDoesNotHaveContents("This Post Has Been Deleted");

        $this->request->reset();

        $this->request->dispatch("/tag/music");

        $this->assertBodyHasContents("This Is A Test Post");

        $this->assertBodyDoesNotHaveContents("Another Test Post");
        $this->assertBodyDoesNotHaveContents("This post hasn't been published");
        $this->assertBodyDoesNotHaveContents("This Post Has Been Deleted");
    }

    public function testTagSearchWithSpaces() {
        $this->request->dispatch("/tag/server administration");

        $this->assertBodyHasContents("Testing Tags");
    }

    public function testTagSearchWithNoResults() {
        $this->request->dispatch("/tag/no match found here");

        $this->assertBodyHasContents("Sorry - no posts match this tag.");
    }

    public function testTagSearchWithDots() {
        $this->request->dispatch("/tag/node.js");

        $this->assertBodyHasContents("Testing Tags");
    }

    public function testTagSearchWithNumbers() {
        $this->request->dispatch("/tag/html5");
        $this->assertBodyHasContents("Sorry - no posts match this tag.");
    }

    public function testCommentsStringShownCorrectly() {
        $this->request->dispatch("/2011/09/another-test-post");
        $this->assertBodyHasContents("<a class='no-pjax' href='/2011/09/another-test-post#comments'>2 comments</a>");
    }

    public function testAuthorTwitterUrlsAreCorrect() {
        $this->request->dispatch("/2011/09/another-test-post");
        $this->assertBodyHasContents("<a href=\"http://twitter.com/anotherUser\"");
    }

    public function testViewMonthWithMatchingPosts() {
        $this->request->dispatch("/2011/07");
        $this->assertBodyHasContents("Posts from July 2011");
        $this->assertBodyHasContents("Just A Test");

        $this->assertBodyDoesNotHaveContents("Another Test Post");
    }

    public function testViewMonthWithNoPosts() {
        $this->request->dispatch("/2011/01");
        $this->assertBodyHasContents("Sorry - there are no posts for this month.");
    }

    public function testIndexShowsMonthArchive() {
        $this->request->dispatch("/articles");

        $this->assertBodyHasContents("September 2011");
        $this->assertBodyHasContents("July 2011");
    }

    public function testBurnAfterReadingUrlReturnsErrorResponseWithNotFoundIdentifier() {
        try {
            $this->request->dispatch("/burn-after-reading/ABC123");
        } catch (CoreException $e) {
            $this->assertEquals(CoreException::URL_NOT_FOUND, $e->getCode());
            return;
        }
        $this->fail("Expected exception not raised");
    }

    public function testBurnAfterReadingUrlReturnsErrorResponseWithRedeemedIdentifier() {
        try {
            $this->request->dispatch("/burn-after-reading/BxF45sZf");
        } catch (CoreException $e) {
            $this->assertEquals(CoreException::URL_NOT_FOUND, $e->getCode());
            return;
        }
        $this->fail("Expected exception not raised");
    }

    public function testBurnAfterReadingRedirectsWithValidIdentifier() {
        $this->request->dispatch("/burn-after-reading/AbDx041F");
        $this->assertRedirect(true);
        $this->assertRedirectUrl("/2010/01/not-published-yet");

        $this->request->reset();
        $this->request->dispatch("/2010/01/not-published-yet");
        $this->assertBodyHasContents("This post hasn't been published");
    }

    public function testHeadBlockAddsContentWhenProvided() {
        $this->request->dispatch("/2011/09/this-is-a-test-post");
        $this->assertBodyHasContents("<link rel=\"stylesheet\" type=\"text/css\" href=\"/foo/bar.css\" />", Table::factory('Posts')->read(3)->head_block);
    }

    public function testScriptBlockAddsContentWhenProvided() {
        $this->request->dispatch("/2011/09/this-is-a-test-post");
        $this->assertBodyHasContents("<script type=\"text/javascript\" src=\"/foo/bar.js\"></script>", Table::factory('Posts')->read(3)->script_block);
    }

    public function testCommentUnsubscribe() {
        $this->request->dispatch("/comment-unsubscribe/a80cf660b49c20ec5ee5e79988c25549a13e50aa");

        $this->assertRedirect(true);
        $this->assertRedirectUrl("/2011/09/another-test-post?ok");

        $this->request->reset();
        $this->request->setParams(array("ok" => true));
        $this->request->dispatch("/2011/09/another-test-post");
        $this->assertBodyHasContents("You have been unsubscribed from new comment notifications on this article");
    }

    public function testCommentUnsubscribeWithInvalidHash() {
        try {
            $this->request->dispatch("/comment-unsubscribe/1234abcd");
        } catch (CoreException $e) {
            $this->assertEquals(CoreException::URL_NOT_FOUND, $e->getCode());
            return;
        }
        $this->fail("Expected exception not raised");
    }

    public function testArticlesListingPageHasRssIntroBlurb() {
        $this->request->dispatch("/articles");
        $this->assertBodyHasContents("An <a href=\"/feed.xml\">RSS feed</a> of the ten latest articles");
    }

    public function testRelatedArticlesHeaderNotShownIfNoneSet() {
        $this->request->dispatch("/2011/09/this-is-a-test-post");
        $this->assertBodyDoesNotHaveContents("Related Articles");
    }

    public function testRelatedArticlesShownIfSet() {
        $this->request->dispatch("/2011/09/testing-tags");
        $this->assertBodyHasContentsInOrder("Related Articles");
        $this->assertBodyHasContentsInOrder("Another Test Post");
        $this->assertBodyHasContentsInOrder("This Is A Test Post");
    }

    public function testRelatedArticlesOnlyShowPublished() {
        $this->request->dispatch("/2011/07/just-a-test");
        $this->assertBodyHasContentsInOrder("Related Articles");
        $this->assertBodyHasContentsInOrder("This Is A Test Post");
        $this->assertBodyDoesNotHaveContents("This post hasn't been published");
    }

    public function testCommentsFormShownOnEnabledPost() {
        $this->request->dispatch("/2011/07/just-a-test");

        $this->assertBodyHasContentsInOrder("Comments");
        $this->assertBodyHasContentsInOrder("Add Your Own");
        $this->assertBodyDoesNotHaveContents("Comments are now closed.");
    }

    public function testCommentsFormNotShownOnDisabledPost() {
        $this->request->dispatch("/2011/03/test-post-for-comments");

        $this->assertBodyHasContentsInOrder("Comments");
        $this->assertBodyHasContentsInOrder("Comments are now closed.");
        $this->assertBodyDoesNotHaveContents("Add Your Own");
    }

    public function testCommentSubmissionOnDisabledPost() {
        TestEmailHandler::resetSentEmails();

        $this->request->setMethod("POST")->setParams(array(
            "name" => "Valid Comment",
            "email" => "test@example.com",
            "content" => "This is a valid message, but comments are disabled",
        ))->dispatch("/2011/03/test-post-for-comments/comment");

        $emails = TestEmailHandler::getSentEmails();
        $this->assertEquals(0, count($emails));

        $this->assertRedirect(true);
        $this->assertRedirectUrl("/2011/03/test-post-for-comments");
    }
}
