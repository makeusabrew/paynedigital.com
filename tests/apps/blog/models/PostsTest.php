<?php
class PostsTableTest extends PHPUnitTestController {
    protected static $fixture_file = "pd_clean";

    protected $table = null;

    public function setUp() {
        parent::setUp();

        Utils::reset();
        Utils::setCurrentDate("2011-09-19 00:00:00");

        $this->table = Table::factory("Posts");
    }

    public function testFindRecentIgnoresNonPublishedAndFuturePublishedPosts() {
        $this->assertEquals(4, count($this->table->findRecent()));
    }

    public function testFindByUrlIgnoresFuturePosts() {
        $this->assertFalse($this->table->findByMonthAndUrl("2021-01", "this-post-will-be-published-in-future"));
    }

    public function testFindByTagIgnoresFuturePosts() {
        $this->assertEquals(3, count($this->table->findAllForTag('test')));
    }
    
    public function testFindByTagOrTitleFuturePosts() {
        $this->assertEquals(3, count($this->table->findAllForTag('test')));
    }

    public function testFindByUrlRetrievesPostAsSoonAsPublished() {
        Utils::setCurrentDate("2020-21-31 23:59:59");
        $this->assertFalse($this->table->findByMonthAndUrl("2021-01", "this-post-will-be-published-in-future"));
        Utils::setCurrentDate("2021-01-01 00:00:00");
        $this->assertTrue(($this->table->findByMonthAndUrl("2021-01", "this-post-will-be-published-in-future") instanceof Post));
    }

    public function testFindMonthsWithPublishedPostsDoesNotReturnDuplicates() {
        $this->assertEquals(array(
            "2011-09-01",
            "2011-07-01",
        ), $this->table->findMonthsWithPublishedPosts());
    }

    public function testFindAllTagsReturnsNaturallySortedArray() {
        $this->assertEquals(array(
            "apache",
            "music",
            "node.js",
            "php",
            "Server Administration",
            "test",
            "web",
            // I don't like array_values() here, but we really don't care about the keys, just that the
            // values are actually in "order"
        ), array_values($this->table->findAllTags()));
    }
}
