<?php
/**
 * @group selenium
 */

class ContactTest extends SeleniumTestController {
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

    public function testContactFormWithValidData() {
        $this->open("/contact");
        $this->type("id=name", "Test User");
        $this->type("id=email", "test@example.com");
        $this->type("id=content", "This is a test enquiry generated at ".date("Y-m-d H:i:s"));
        $this->click("//form/div/input[@type='submit']");
        $this->waitForPageToLoad(5000);
        $this->assertTitle("Payne Digital Ltd - Thanks!");
        $this->assertTextPresent("Thanks!");
    }
}
