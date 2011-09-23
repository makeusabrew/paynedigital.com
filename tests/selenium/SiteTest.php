<?php
/**
 * @group selenium
 */

class SiteTest extends SeleniumTestController {
    public static $browsers = array(
        array(
            "name" => "Firefox",
            "browser" => "*firefox",
            "host" => "ff.vm.linux",
            "port" => 4444,
            "timeout" => 30000,
        ),
        /*
        array(
            "name" => "IE7",
            "browser" => "*iexplore",
            "host" => "ie7.vm.winxp",
            "port" => 4444,
            "timeout" => 30000,
        ),
        array(
            "name" => "Safari",
            "browser" => "*safari",
            "host" => "127.0.0.1",
            "port" => 4444,
            "timeout" => 30000,
        ),
        array(
            "name" => "Chrome",
            "browser" => "*googlechrome",
            "host" => "chrome.vm.linux",
            "port" => 4444,
            "timeout" => 30000,
        ),
        */
    );

    public function setUp() {
        parent::setUp();
        $this->setBrowserUrl(Settings::getValue("site.base_href"));
    }

    public function testHomepageTitle() {
        $this->open("/");
        $this->assertTitle('Payne Digital Ltd');
    }

    public function testHomepageContents() {
        $this->open("/");
        $this->assertTextPresent('Web, Mobile, Apps & Games. Whatever you need, we can build it.');
    }

    public function testNavigationLinksArePresentAndHaveCorrectTitles() {
        $this->open("/");
        // don't click home, just make sure it's there
        $this->assertElementPresent("//ul[@class='nav']/li/a[@href='/' and text()='Home']");

        // click the others to make sure their page titles are correct
        $this->click("//ul[@class='nav']/li/a[@href='/about' and text()='About']");
        $this->waitForPageToLoad(5000);
        $this->assertTitle("Payne Digital Ltd - About");
        $this->open("/");
        $this->click("//ul[@class='nav']/li/a[@href='/services' and text()='Services']");
        $this->waitForPageToLoad(5000);
        $this->assertTitle("Payne Digital Ltd - Services");
        $this->open("/");
        $this->click("//ul[@class='nav']/li/a[@href='/contact' and text()='Say Hello']");
        $this->waitForPageToLoad(5000);
        $this->assertTitle("Payne Digital Ltd - Say Hello");
        $this->open("/");
        $this->click("//ul[@class='nav']/li/a[@href='/articles' and text()='Articles']");
        $this->waitForPageToLoad(5000);
        $this->assertTitle("Payne Digital Ltd - Articles");
    }
}
