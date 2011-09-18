<?php

class BlogControllerTest extends PHPUnitTestController {
    public function setUp() {
        parent::setUp();
        $this->request->setParams(array(
            "base_href" => Settings::getValue("site.base_href")
        ));
    }

    public function testIndexAction() {
        $this->request->dispatch("/");
        $this->assertResponseCode(200);
        $this->assertController("Default");
        $this->assertApp("default");
        $this->assertAction("index");
    }

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
            $this->request->dispatch("/2011/09/not-published-yet");
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
        // @todo fix the dispatch stuff? - it chokes on anchor tags. poss not required
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

    public function testCommentsStringShownCorrectly() {
        $this->request->dispatch("/2011/09/another-test-post");
        $this->assertBodyHasContents("<a href='/2011/09/another-test-post#comments'>2 comments</a>");
    }

    public function testAuthorTwitterUrlsAreCorrect() {
        $this->request->dispatch("/2011/09/another-test-post");
        $this->assertBodyHasContents("<a href=\"http://twitter.com/anotherUser\"");
    }
}
