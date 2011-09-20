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

    public function testAdminLoginProcessForValidUser() {
        $this->open("/admin/login");
        $this->assertTextPresent("Login");
        $this->type("id=email", "test@example.com");
        $this->type("id=password", "t3stp4ss");
        $this->submit("//form");
        $this->waitForPageToLoad(10000);
        $this->assertTextPresent("Hi Test");
    }
}
