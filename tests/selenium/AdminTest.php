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
}
