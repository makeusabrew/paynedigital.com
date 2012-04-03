<?php

class CommentObjectTest extends PHPUnitTestController {
    protected static $fixture_file = "pd_clean";

    public function testHasNeverBeenApproved() {
        // never approved
        $comment = Table::factory('Comments')->read(3);
        $this->assertEquals(0, $comment->approved);
        $this->assertTrue($comment->hasNeverBeenApproved());

        // previously approved
        $comment = Table::factory('Comments')->read(5);
        $this->assertEquals(0, $comment->approved);
        $this->assertFalse($comment->hasNeverBeenApproved());
    }

    public function testEmailOnApprovalIsTrueWhenPreferenceSet() {
        $comment = Table::factory('Comments')->read(3);
        $this->assertTrue($comment->emailOnApproval());
    }

    public function testEmailOnApprovalIsFalseWhenPreferenceNotSet() {
        $comment = Table::factory('Comments')->read(4);
        $this->assertFalse($comment->emailOnApproval());

        // this comment has nothing at all
        $comment = Table::factory('Comments')->read(5);
        $this->assertFalse($comment->emailOnApproval());
    }

    public function testEmailOnNewIsTrueWhenPreferenceSet() {
        $comment = Table::factory('Comments')->read(3);
        $this->assertTrue($comment->emailOnNew());

        $comment = Table::factory('Comments')->read(4);
        $this->assertTrue($comment->emailOnNew());
    }

}
