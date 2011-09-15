<?php

class Contact extends Object {
}

class Contacts extends Table {
    protected $meta = array(
        'columns' => array(
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
                'title' => 'Message',
                'type' => 'textarea',
                'required' => true,
            ),
        ),
    );
}
