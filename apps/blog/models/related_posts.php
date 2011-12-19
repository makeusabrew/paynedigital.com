<?php

class RelatedPost extends Object {
    //
}

class RelatedPosts extends Table {
    protected $order_by = "`sort_order` ASC";
    protected $meta = array(
        'columns' => array(
            'sort_order' => array(
                'type' => 'number',
                'validation' => array('unsigned'),
            ),
            'post_id' => array(
                'type' => 'number',
                'validation' => array('unsigned'),
            ),
            'related_post_id' => array(
                'type' => 'foreign_key',
                'table' => 'Posts',
            ),
        ),
    );
}
