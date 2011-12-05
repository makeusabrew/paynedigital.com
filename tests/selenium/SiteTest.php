<?php
/**
 * @group selenium
 */

class SiteTest extends SeleniumTestController {
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

    public function testCommentEmails() {
        $this->open("/2011/07/just-a-test");
        $this->type("id=name", "Comment 1");
        $this->type("id=email", "comment1@example.com");
        $this->type("id=content", "comment 1");
        $this->check("id=notifications_email_on_approval");
        $this->check("id=notifications_email_on_new");
        $this->submit("//div[@id='comments']//form");
        $this->waitForTextPresent("Thanks! Your comment has been submitted and will be reviewed shortly.");

        $this->open("/admin/login");
        $this->assertTextPresent("Login");
        $this->type("id=email", "another.test@example.com");
        $this->type("id=password", "t3stp4ss");
        $this->submit("//form");
        $this->waitForPageToLoad(5000);

        DbEmailHandler::resetSentEmails();
        $this->open("/admin/posts/7/comments");
        $this->select("//div[@class='container']/form[1]//select[@name='approved']", "Yes");
        $this->submit("//div[@class='container']/form[1]");
        $this->waitForPageToLoad(5000);
        $this->assertTextPresent("Comment Updated");
        $emails = DbEmailHandler::getSentEmails();

        $this->assertEquals(1, count($emails));
        $this->assertEquals("Your comment has been approved", $emails[0]['subject']);
        $this->assertEquals("Comment 1 <comment1@example.com>", $emails[0]['to']);


        // add a new comment, check email on new and approved
        $this->open("/2011/07/just-a-test");
        $this->type("id=name", "Comment 2");
        $this->type("id=email", "comment2@example.com");
        $this->type("id=content", "comment 2");
        $this->check("id=notifications_email_on_approval");
        $this->check("id=notifications_email_on_new");
        $this->submit("//div[@id='comments']//form");
        $this->waitForTextPresent("Thanks! Your comment has been submitted and will be reviewed shortly.");
        // approve comment
        DbEmailHandler::resetSentEmails();
        $this->open("/admin/posts/7/comments");
        $this->select("//div[@class='container']/form[2]//select[@name='approved']", "Yes");
        $this->submit("//div[@class='container']/form[2]");
        $this->waitForPageToLoad(5000);
        $this->assertTextPresent("Comment Updated");
        $emails = DbEmailHandler::getSentEmails();

        // assert  test email sent (approved)
        $this->assertEquals(2, count($emails));
        $this->assertEquals("Your comment has been approved", $emails[0]['subject']);
        $this->assertEquals("Comment 2 <comment2@example.com>", $emails[0]['to']);
        // assert test email sent to 1st commenter (new)
        $this->assertEquals("A new comment has been added", $emails[1]['subject']);
        $this->assertEquals("Comment 1 <comment1@example.com>", $emails[1]['to']);

        // add a new comment, check nothing
        $this->open("/2011/07/just-a-test");
        $this->type("id=name", "Comment 3");
        $this->type("id=email", "comment3@example.com");
        $this->type("id=content", "comment 3");
        $this->submit("//div[@id='comments']//form");
        $this->waitForTextPresent("Thanks! Your comment has been submitted and will be reviewed shortly.");
        // approve comment
        DbEmailHandler::resetSentEmails();
        $this->open("/admin/posts/7/comments");
        $this->select("//div[@class='container']/form[3]//select[@name='approved']", "Yes");
        $this->submit("//div[@class='container']/form[3]");
        $this->waitForPageToLoad(5000);
        $this->assertTextPresent("Comment Updated");
        $emails = DbEmailHandler::getSentEmails();

        // assert two emails sent RE new comment
        $this->assertEquals(2, count($emails));
        $this->assertEquals("A new comment has been added", $emails[0]['subject']);
        $this->assertEquals("Comment 1 <comment1@example.com>", $emails[0]['to']);
        $this->assertEquals("A new comment has been added", $emails[1]['subject']);
        $this->assertEquals("Comment 2 <comment2@example.com>", $emails[1]['to']);
        // unsubscribe one commenter from new emails
        // check flash message present
        // add a new comment, check nothing
        // approve comment
        // assert one test email sent RE new comment
        // unsubscribe last commenter from new emails
        // add a new comment, check nothing
        // approve comment
        // assert no emails sent
    }
}
