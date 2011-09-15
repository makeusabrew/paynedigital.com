<?php
/**
 * @group selenium
 */

class BlogTest extends SeleniumTestController {
    protected static $fixture_file = "pd_clean";

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

    public function testHomepageShowsRecentPostsInCorrectOrder() {
        $this->open("/");
        // not massively keen on such tight DOM bounding, but let's see how it goes...
        $this->assertElementPresent("//body/div[@class='container']/div[@class='post'][1]/h2/a[text()='Another Test Post']");
        $this->assertElementPresent("//body/div[@class='container']/div[@class='post'][2]/h2/a[text()='This Is A Test Post']");
    }

    // @todo could move this to a headless browser test?
    public function testHomepageDoesNotShowDraftPosts() {
        $this->assertTextNotPresent("This post hasn't been published");
    }

    // @todo could move this to a headless browser test?
    public function testHomepageDoesNotShowDeletedPosts() {
        $this->assertTextNotPresent("This Post Has Been Deleted");
    }
}
