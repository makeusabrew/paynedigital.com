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

    public function testGetComments() {
        $this->assertEquals(1, count(Table::factory('Posts')->read(1)->getComments()));
        $this->assertEquals(3, count(Table::factory('Posts')->read(3)->getComments()));
    }

    public function testGetUnapprovedCommentsCount() {
        $this->assertEquals(1, Table::factory('Posts')->read(1)->getUnapprovedCommentsCount());
        $this->assertEquals(1, Table::factory('Posts')->read(3)->getUnapprovedCommentsCount());
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

    public function testGetHeadBlock() {
        $this->assertEquals("<link rel=\"stylesheet\" type=\"text/css\" href=\"/foo/bar.css\" />", Table::factory('Posts')->read(1)->head_block);
        $this->assertEquals("", Table::factory('Posts')->read(3)->head_block);
    }

    public function testGetScriptBlock() {
        $this->assertEquals("<script type=\"text/javascript\" src=\"/foo/bar.js\"></script>", Table::factory('Posts')->read(1)->script_block);
        $this->assertEquals("", Table::factory('Posts')->read(3)->head_block);
    }
}
