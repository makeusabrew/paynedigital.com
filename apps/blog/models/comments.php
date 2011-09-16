<?php

class Comment extends Object {
}

class Comments extends Table {
    protected $order_by = '`created` DESC';
    protected $meta = array(
        'columns' => array(
            'post_id' => array(
                'type' => 'foreign_key',
                'model' => 'Posts',
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
            'approved' => array(
                'type' => 'bool',
            ),
        ),
    );
}
