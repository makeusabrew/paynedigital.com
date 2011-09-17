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
    );

    public function setUp() {
        parent::setUp();
        $this->setBrowserUrl(Settings::getValue("site.base_href"));
    }

    public function testHomepageShowsRecentPostsInCorrectOrder() {
        $this->open("/");
        // not massively keen on such tight DOM bounding, but let's see how it goes...
        $this->assertElementPresent("//div[@id='posts']/div[@class='post'][1]//h2/a[text()='Another Test Post']");
        $this->assertElementPresent("//div[@id='posts']/div[@class='post'][2]//h2/a[text()='This Is A Test Post']");
    }

    public function testPostLinksFromHomepageAreCorrect() {
        $this->open("/");
        $this->assertElementPresent("//div[@id='posts']/div[@class='post'][1]//h2/a[@href='/2011/09/another-test-post']");
    }

    public function testStandalonePostPageTitle() {
        $this->open("/2011/09/another-test-post");
        $this->assertTitle("Payne Digital Ltd - Another Test Post");
    }

    public function testCommentFormWithValidData() {
        $this->open("/2011/09/another-test-post");
        $this->type("id=name", "Test User");
        $this->type("id=email", "test@example.com");
        $this->type("id=content", "This is a test comment generated at ".date("Y-m-d H:i:s"));
        $this->click("//form/div/input[@type='submit']");
        $this->waitForTextPresent("Thanks! Your comment has been submitted and will be reviewed shortly.");
    }

    public function testApprovedCommentsAreVisibleInCorrectOrder() {
        $this->open("/2011/09/another-test-post");
        $this->assertElementPresent("//body//div[@id='comments']/div/div[@class='comment'][1]//time[text()='16th September 2011 at 12:56']");
        $this->assertElementPresent("//body//div[@id='comments']/div/div[@class='comment'][2]//time[text()='15th September 2011 at 09:33']");
    }
}
