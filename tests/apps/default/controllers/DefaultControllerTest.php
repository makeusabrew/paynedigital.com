<?php

class DefaultControllerTest extends PHPUnitTestController {
    public function setUp() {
        parent::setUp();
        $this->request->setProperties(array(
            "base_href" => Settings::getValue("site.base_href")
        ));
    }

    public function testIndexAction() {
        $this->request->dispatch("/");
        $this->assertResponseCode(200);
        $this->assertController("Default");
        $this->assertApp("default");
        $this->assertAction("index");
    }
}
