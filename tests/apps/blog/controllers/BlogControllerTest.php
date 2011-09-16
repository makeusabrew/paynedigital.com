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
        $this->assertBodyHasContents("Thanks! Your comment has been submitted and will be reviewed shortly.");
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
}
