<?php

class FeedControllerTest extends PHPUnitTestController {
    public function testFeedHasCorrectTitle() {
        $this->request->dispatch("/feed.xml");
        $this->assertBodyHasContents("<title>Payne Digital</title>");
    }
}
