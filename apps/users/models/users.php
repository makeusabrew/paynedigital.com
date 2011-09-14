<?php

class User extends Object {
    public function getDisplayName() {
        return $this->forename." ".$this->surname;
    }
}

class Users extends Table {
    protected $meta = array(
        'columns' => array(
            'email' => array(
                'type' => 'email',
            ),
            'forename' => array(
                'type' => 'text',
            ),
            'surname' => array(
                'type' => 'text',
            ),
        ),
    );
}
