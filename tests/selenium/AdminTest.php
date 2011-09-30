<?php
/**
 * @group selenium
 */

class AdminTest extends SeleniumTestController {
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

    protected function doValidLogin() {
        $this->open("/admin/login");
        $this->assertTextPresent("Login");
        $this->type("id=email", "test@example.com");
        $this->type("id=password", "t3stp4ss");
        $this->submit("//form");
        $this->waitForPageToLoad(10000);
    }

    public function testAdminLoginProcessForValidUser() {
        $this->doValidLogin();
        $this->assertTextPresent("Hi Test");
    }

    public function testAdminIndexShowsUsersPosts() {
        $this->doValidLogin();
        $this->assertTextPresent("This Is A Test Post");
        $this->assertTextPresent("This post hasn't been published");
        $this->assertTextPresent("This Post Has Been Deleted");
        $this->assertTextPresent("This post will be published in the future");

        // make sure we can't see others' posts
        $this->assertTextNotPresent("Another Test Post");
    }

    // @todo need more accurate selectors to verify edited content
    public function testAdminEditProcess() {
        $this->doValidLogin();
        $this->open("/admin/posts/edit/1");
        $this->type("id=title", "Test Post (Edited)");
        $this->select("id=status", "Draft");
        $this->type("id=published", "01/09/11 12:34:56");
        $this->submit("//form");
        $this->waitForPageToLoad(10000);
        $this->assertTextPresent("Test Post (Edited)");
        $this->assertTextPresent("2011-09-01 12:34:56");
        $this->open("/");
        // this post shouldn't be there anymore as it's been changed to a draft
        $this->assertTextNotPresent("Test Post (Edited");
    }

    public function testAdminAddPost() {
        $this->doValidLogin();
        $this->open("/admin/posts/add");
        $this->type("id=title", "A New Post");
        $this->type("id=url", "a-new-post");
        $this->select("id=status", "Published");
        $this->type("id=published", "22/09/2011 11:54:51");
        $this->type("id=content", "<p>Here is some test content.</p>");
        $this->type("id=tags", "|test|tags|");
        $this->submit("//form");
        $this->waitForPageToLoad(10000);
        $this->assertTextPresent("A New Post");
        $this->assertTextPresent("2011-09-22 11:54:51");
        $this->open("/");
        $this->assertElementPresent("//div[@id='posts']/div[@class='post'][1]//h2/a[text()='A New Post']");
        $this->open("/2011/09/a-new-post");
        $this->assertTextPresent("A New Post");
        $this->assertTextPresent("Here is some test content.");
    }

    public function testBurnAfterReadingGenerationWithDraftPost() {
        $this->doValidLogin();
        $this->open("/admin/posts/edit/2");
        $this->assertTextPresent("Generate Burn Link");
        $this->click("//form//div//a");
        $this->waitForPageToLoad(50000);
        $this->click("id=burn-link");
        $this->waitForPageToLoad(50000);
        $this->assertTextPresent("This post hasn't been published");
    }

}
