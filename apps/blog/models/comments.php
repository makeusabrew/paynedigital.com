<?php

class Comment extends Object {
    public function hasNeverBeenApproved() {
        return ($this->approved_at == null ||
                $this->approved_at == "0000-00-00 00:00:00");
    }

    public function getNotifications() {
        return json_decode($this->notifications, true);
    }

    public function emailOnApproval() {
        $notifications = $this->getNotifications();
        return (isset($notifications['email_on_approval']) && $notifications['email_on_approval']);
    }

    public function emailOnNew() {
        $notifications = $this->getNotifications();
        return (isset($notifications['email_on_new']) && $notifications['email_on_new']);
    }

    public function getUnsubscribeHash() {
        return sha1($this->id.$this->post_id.$this->ip.$this->email);
    }
}

class Comments extends Table {
    protected $order_by = '`created` ASC';
    protected $meta = array(
        'columns' => array(
            'post_id' => array(
                'type' => 'foreign_key',
                'table' => 'Posts',
                'required' => true,
            ),
            'ip' => array(
                'type' => 'text',
                'required' => true,
            ),
            'name' => array(
                'title' => 'Your Name',
                'type' => 'text',
                'required' => true,
            ),
            'email' => array(
                'title' => 'Email Address',
                'type' => 'email',
                'required' => true,
            ),
            'content' => array(
                'title' => 'Comment',
                'type' => 'textarea',
                'required' => true,
            ),
            'notifications' => array(
                'title' => 'Notification Options',
                'type' => 'checkbox',
                "options" => array(
                    "email_on_approval" => "Email me when my comment is approved",
                    "email_on_new"      => "Email me when new comments are posted",
                ),
            ),
            'approved' => array(
                'type' => 'bool',
            ),
            'approved_at' => array(
                'type' => 'datetime',
            ),
        ),
    );

    public function findOthersForPost($post_id, $comment_id) {
        return $this->findAll("`post_id` = ? AND `id` <> ?", array($post_id, $comment_id));
    }

    public function findByHash($hash) {
        return $this->find("SHA1(CONCAT(`id`, `post_id`, `ip`, `email`)) = ?", array($hash));
    }
}
