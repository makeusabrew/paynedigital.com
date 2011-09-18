<?php

class ContactControllerTest extends PHPUnitTestController {
    public function setUp() {
        parent::setUp();
        $this->request->setProperties(array(
            "base_href" => Settings::getValue("site.base_href")
        ));
    }

    public function testContactFormWithValidData() {
        $this->request->setMethod("POST")->setParams(array(
            "name" => "Test Person",
            "email" => "test@example.com",
            "content" => "This is a test message",
        ))->dispatch("/contact");

        $this->assertRedirect(true);
        $this->assertRedirectUrl("/contact/thanks");
        $this->request->reset();
        $this->request->dispatch("/contact/thanks");
        $this->assertBodyHasContents("Thanks!");
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
