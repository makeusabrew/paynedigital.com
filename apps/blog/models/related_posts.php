<?php

class RelatedPost extends Object {
    //
}

class RelatedPosts extends Table {
    protected $order_by = "`sort_order` ASC";
    protected $meta = array(
        'columns' => array(
            'sort_order' => array(
                'title' => 'Sort Order',
                'type' => 'number',
                'validation' => array('unsigned'),
                'required' => true,
            ),
            'post_id' => array(
                'type' => 'number',
                'validation' => array('unsigned'),
                'required' => true,
            ),
            'related_post_id' => array(
                'title' => 'Related Post',
                'type' => 'foreign_key',
                'table' => 'Posts',
                'required' => true,
            ),
        ),
    );
}
