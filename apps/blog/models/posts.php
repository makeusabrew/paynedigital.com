<?php

class Post extends Object {
    public function getUrl() {
        return date("Y/m")."/".$this->url;
    }
}

class Posts extends Table {
    protected $order_by = '`created` DESC';
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

    public function findRecentPublished($x = 10) {
        return $this->findAll(array(
            "status" => "PUBLISHED",
        ), null, $x);
    }
}
