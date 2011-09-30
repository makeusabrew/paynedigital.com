<?php

class Preview extends Object {
    protected static $range = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    public function generateUniqueIdentifier() {
        do {
            $identifier = $this->generateIdentifier();
        } while (Table::factory("Previews")->findByIdentifier($identifier) !== false);
        return $identifier;
    }

    public function setUniqueIdentifier() {
        $this->updateValues(array(
            "identifier" => $this->generateUniqueIdentifier(),
        ));
    }

    protected function generateIdentifier($length = 8) {
        $max = strlen(self::$range) - 1;
        $str = "";
        for ($i = 0; $i < $length; $i++) {
            $str .= self::$range{mt_rand(0, $max)};
        }
        return $str;
    }

    public function redeem() {
        $this->updateValues(array(
            "quantity" => $this->quantity - 1
        ));
    }
}

class Previews extends Table {
    protected $meta = array(
        "columns" => array(
            "user_id" => array(
                "type" => "foreign_key",
                "table" => "Users",
            ),
            "post_id" => array(
                "type" => "foreign_key",
                "table" => "Users",
            ),
            "quantity" => array(
                "type" => "number",
            ),
            "identifier" => array(
                "type" => "text",
            ),
        ),
    );

    public function findByIdentifier($identifier) {
        return $this->find(array(
            "identifier" => $identifier,
        ));
    }
    
    public function findRedeemableByIdentifier($identifier) {
        return $this->find("`identifier` = ? AND `quantity` > ?", array(
            $identifier,
            0,
        ));
    }
}
