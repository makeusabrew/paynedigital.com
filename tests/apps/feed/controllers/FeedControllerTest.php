<?php

class FeedControllerTest extends PHPUnitTestController {
    public function testFeedHasCorrectTitle() {
        $this->request->dispatch("/feed.xml");
        $this->assertBodyHasContents("<title>Payne Digital</title>");
    }

    public function testAlternateFeedLinkIsPresentOnHomepage() {
        $this->request->dispatch("/");
        $this->assertBodyHasContents('<link rel="alternate" type="application/rss+xml" title="Payne Digital RSS Feed" href="'.Settings::getValue('site.base_href').'feed.xml"/>');
    }

    public function testFeedSetsCorrectContentTypeHeader() {
        $this->request->dispatch("/feed.xml");
        $headers = $this->request->getResponse()->getHeaders();

        $this->assertTrue(isset($headers['Content-Type']));
        $this->assertEquals('text/xml; charset=utf-8', $headers['Content-Type']);
    }
}
