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
}
