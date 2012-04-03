<?php

class SearchControllerTest extends PHPUnitTestController {
    public function testSearchWithNoResults() {
        $this->request->setParams(array(
            "q" => "no matching content",
        ))->dispatch("/search");

        $this->assertBodyHasContents("Sorry - no posts match this query.");
    }

    public function testSearchWithResults() {
        $this->request->setParams(array(
            "q" => "test",
        ))->dispatch("/search");

        $this->assertBodyHasContents("Another Test Post");
        $this->assertBodyHasContents("This Is A Test Post");
        $this->assertBodyHasContents("Testing Tags");
        $this->assertBodyHasContents("Just A Test");
    }

    public function testSearchWithNoQuery() {
        $this->request->dispatch("/search");

        $this->assertBodyHasContents("Sorry - you must enter a query.");
    }
}
