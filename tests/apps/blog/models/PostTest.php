<?php

class PostObjectTest extends PHPUnitTestController {
    protected static $fixture_file = "pd_clean";

    public function testGetApprovedComments() {
        $this->assertEquals(0, count(Table::factory('Posts')->read(1)->getApprovedComments()));
        $this->assertEquals(2, count(Table::factory('Posts')->read(3)->getApprovedComments()));
    }

    public function testGetApprovedCommentsCount() {
        $this->assertEquals(0, Table::factory('Posts')->read(1)->getApprovedCommentsCount());
        $this->assertEquals(2, Table::factory('Posts')->read(3)->getApprovedCommentsCount());
    }

    public function testGetTags() {
        $this->assertEquals(array(
            "web",
            "apache",
            "music",
            "test",
        ), Table::factory('Posts')->read(1)->getTags());
    }

    public function testGetTagsWithEmptyFieldValue() {
        $this->assertEquals(array(), Table::factory('Posts')->read(7)->getTags());
    }

    public function testGetTagsAsString() {
        $this->assertEquals(
            "web, apache, music, test",
            Table::factory('Posts')->read(1)->getTagsAsString()
        );
    }
}
