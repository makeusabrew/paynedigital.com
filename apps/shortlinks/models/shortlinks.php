<?php

class Shortlink extends Object {
}

class Shortlinks extends Table {
    protected $meta = array(
        'columns' => array(
            'url' => array(
                'type' => 'text',
            ),
            'redirect_url' => array(
                'type' => 'text',
            ),
        ),
    );

    public function findByUrl($url) {
        return $this->find(array(
            "url" => $url,
        ));
    }
}
