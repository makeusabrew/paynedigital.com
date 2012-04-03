<?php
class UsersTableTest extends PHPUnitTestController {
    protected static $fixture_file = "pd_clean";

    protected $table = null;

    public function setUp() {
        parent::setUp();
        $this->table = Table::factory("Users");
    }

    public function testLoadFromSessionReturnsNonAuthedUserByDefault() {
        $user = $this->table->loadFromSession();
        $this->assertFalse($user->isAuthed());
    }

    public function testLoadFromSessionReturnsNonAuthedUserWithInvalidSessionUserId() {
        Session::getInstance()->user_id = 9999;
        $user = $this->table->loadFromSession();
        $this->assertFalse($user->isAuthed());
    }

    public function testLoadFromSessionReturnsAuthedUserWithValidSessionUserId() {
        Session::getInstance()->user_id = 1;
        $user = $this->table->loadFromSession();
        $this->assertTrue($user->isAuthed());
    }

    public function testLoginMethod() {
        $user = $this->table->login("test@example.com", "t3stp4ss");
        $this->assertTrue($user instanceof User);
    }
}
