<?php

class User extends Object {
    /**
     * keep track of whether this user is authed (logged in)
     * or not
     */
    protected $isAuthed = false;

    /**
     * bung this user's ID in the session
     */
    public function addToSession() {
        $s = Session::getInstance();
        $s->user_id = $this->getId();
        if ($s->user_id === null) {
            Log::warn("Adding null user ID to session");
        }
        $this->setAuthed(true);
    }
    
    /**
     * remove this user from the session
     */
    public function logout() {
    	$s = Session::getInstance();
    	unset($s->user_id);
        $this->setAuthed(false);
    }

    /**
     * is this user authenticated?
     */
    public function isAuthed() {
        return $this->isAuthed;
    }

    /**
     * update this user's authed state
     */
    public function setAuthed($authed) {
        $this->isAuthed = $authed;
    }

    public function getDisplayName() {
        return $this->forename." ".$this->surname;
    }

    protected function encode($value) {
        $salt = Utils::generatePassword(32);
        return $salt.".".$this->generateHash($salt, $value);
    }

    protected function generateHash($salt, $value) {
        return sha1($salt."-".$value);
    }

    public function verifyPassword($value) {
        list($salt, $hash) = explode(".", $this->password);

        return $hash === $this->generateHash($salt, $value);
    }

    public function toArray() {
        // remove sensitive stuff
        return array_diff_key(parent::toArray(), array("id" => true, "password" => true));
    }

    /**
     * NB this INCLUDES posts which have been deleted or not yet published
     */
    public function getAllPosts() {
        return Table::factory('Posts')->findAll(array(
            "user_id" => $this->getId()
        ));
    }
}

class Users extends Table {
    protected $meta = array(
        'columns' => array(
            'email' => array(
                'type' => 'email',
            ),
            'password' => array(
                'type' => 'password',
            ),
            'forename' => array(
                'type' => 'text',
            ),
            'surname' => array(
                'type' => 'text',
            ),
            'twitter_username' => array(
                'type' => 'text',
            ),
        ),
    );
    
    public function loadFromSession() {
        $s = Session::getInstance();
        $id = $s->user_id;
        if ($id === NULL) {
            return new User();
        }
        $user = $this->read($id);
        if (!$user) {
            // oh dear
            Log::debug("Could not find user id [".$id."]");
            return new User();
        }
        $user->setAuthed(true);
        return $user;
    }

    public function login($identifier, $password) {
        $user = $this->find("`email` = ?", array($identifier));

        if (!$user || !$user->verifyPassword($password)) {
            return false;
        }

        return $user;
    }
}
