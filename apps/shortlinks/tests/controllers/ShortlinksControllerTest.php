<?php

class ShortlinksControllerTest extends PHPUnitTestController {
    /**
     * @dataProvider shortLinksDP 
     */
    public function testShortLinks($url, $redirectUrl) {

        $this->request->dispatch($url);
        $this->assertResponseCode(303);
        $this->assertController("Shortlinks");
        $this->assertApp("shortlinks");
        $this->assertAction("do_redirect");
        $this->assertRedirect(true);
        $this->assertRedirectUrl($redirectUrl);
    }

    public function shortLinksDP() {
        return array(
            array("/bootbox", "/2011/11/bootbox-js-alert-confirm-dialogs-for-twitter-bootstrap"),
            array("/trello",  "https://trello.com/board/paynedigital-com/4eba7ed4538fd4a54b302e23"),
            array("/nodeflakes", "/2011/12/nodeflakes"),
        );
    }
}
