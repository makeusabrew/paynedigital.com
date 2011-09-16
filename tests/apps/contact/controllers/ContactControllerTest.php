<?php

class ContactControllerTest extends PHPUnitTestController {
    public function setUp() {
        parent::setUp();
        $this->request->setParams(array(
            "base_href" => Settings::getValue("site.base_href")
        ));
    }

    public function testContactFormWithNoData() {
        $this->request->setMethod("POST")->setParams(array(
            "name" => "",
            "email" => "",
            "content" => "",
        ))->dispatch("/contact");

        $this->assertBodyHasContents("Your Name is required");
        $this->assertBodyHasContents("Email Address is required");
        $this->assertBodyHasContents("Message is required");
    }

    public function testContactFormWithInvalidEmail() {
        $this->request->setMethod("POST")->setParams(array(
            "name" => "",
            "email" => "email@",
            "content" => "",
        ))->dispatch("/contact");

        $this->assertBodyHasContents("Email Address is not a valid email address");
    }
}
