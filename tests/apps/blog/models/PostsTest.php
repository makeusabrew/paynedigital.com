<?php
class PostsTableTest extends PHPUnitTestController {
    protected static $fixture_file = "pd_clean";

    protected $table = null;

    public function setUp() {
        parent::setUp();

        Utils::reset();
        Utils::setCurrentDate("2011-09-15 00:00:00");

        $this->table = Table::factory("Posts");
    }

    public function testFindRecentIgnoresNonPublishedAndFuturePublishedPosts() {
        $this->assertEquals(2, count($this->table->findRecent()));
    }

    public function testFindByUrlIgnoresFuturePosts() {
        $this->assertFalse($this->table->findByMonthAndUrl("2021-01", "this-post-will-be-published-in-future"));
    }

    public function testFindByTagIgnoresFuturePosts() {
        $this->assertEquals(2, count($this->table->findAllForTag('test')));
    }
    
    public function testFindByTagOrTitleFuturePosts() {
        $this->assertEquals(2, count($this->table->findAllForTag('test')));
    }

    public function testFindByUrlRetrievesPostAsSoonAsPublished() {
        Utils::setCurrentDate("2020-21-31 23:59:59");
        $this->assertFalse($this->table->findByMonthAndUrl("2021-01", "this-post-will-be-published-in-future"));
        Utils::setCurrentDate("2021-01-01 00:00:00");
        $this->assertTrue(($this->table->findByMonthAndUrl("2021-01", "this-post-will-be-published-in-future") instanceof Post));
    }
}
