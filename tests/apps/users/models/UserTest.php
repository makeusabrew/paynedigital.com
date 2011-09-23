<?php

class UserObjectTest extends PHPUnitTestController {
    protected static $fixture_file = "pd_clean";

    public function testNewUserIsNotAuthed() {
        $user = Table::factory('Users')->newObject();

        $this->assertFalse($user->isAuthed());
    }

    public function testSetAuthed() {
        $user = Table::factory('Users')->newObject();

        $user->setAuthed(true);
        $this->assertTrue($user->isAuthed());

        $user->setAuthed(false);
        $this->assertFalse($user->isAuthed());
    }

    public function testAddToSessionSetsUserAsAuthed() {
        $user = Table::factory('Users')->read(1);

        $user->addToSession();
        $this->assertTrue($user->isAuthed());
    }

    public function testLogoutSetsUserAsNotAuthed() {
        $user = Table::factory('Users')->read(1);

        $user->addToSession();
        $user->logout();
        $this->assertFalse($user->isAuthed());
    }

    public function testGetAllPostsCountIsCorrect() {
        $user = Table::factory('Users')->read(1);

        $this->assertEquals(4, count($user->getAllPosts()));
    }
}
