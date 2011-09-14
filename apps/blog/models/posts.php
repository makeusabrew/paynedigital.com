<?php

class Post extends Object {
    //
}

class Posts extends Table {
    protected $meta = array(
        'columns' => array(
            'user_id' => array(
                'type' => 'foreign_key',
                'model' => 'Users', // @todo verify!
            ),
            'title' => array(
                'type' => 'text',
                'required' => true,
            ),
            'url' => array(
                'type' => 'text',
                'required' => true,
            ),
            'content' => array(
                'type' => 'textarea',
                'required' => true,
            ),
            'published' => array(
                'type' => 'datetime',
                'required' => true,
            ),
            // not implemented yet
            'status' => array(
                'type' => 'select',
                'options' => array(
                    'DRAFT',
                    'PUBLISHED',
                    'DELETED',
                ),
            ),
        ),
    );
}
