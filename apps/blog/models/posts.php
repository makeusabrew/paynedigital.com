<?php

class Post extends Object {
    public function getUrl() {
        return date("Y/m", strtotime($this->published))."/".$this->url;
    }

    public function getApprovedComments() {
        return Table::factory('Comments')->findAll(array(
            'post_id' => $this->getId(),
            'approved' => true,
        ));
    }

    public function getApprovedCommentsCount() {
        return Table::factory('Comments')->countAll(array(
            'post_id' => $this->getId(),
            'approved' => true,
        ));
    }

    public function getComments() {
        return Table::factory('Comments')->findAll(array(
            'post_id' => $this->getId(),
        ));
    }

    public function getUnapprovedCommentsCount() {
        return Table::factory('Comments')->countAll(array(
            'post_id' => $this->getId(),
            'approved' => false,
        ));
    }

    public function getTags() {
        return self::convertTagsToArray($this->tags);
    }

    public static function convertTagsToArray($tags) {
        $tags = explode("|", $tags);
        if ($tags === false || count($tags) === 0) {
            return array();
        }
        if (current($tags) == "") {
            array_shift($tags);
        }
        if (end($tags) == "") {
            array_pop($tags);
        }
        return $tags;
    }

    public function getTagsAsString() {
        return implode(", ", $this->getTags());
    }
}

class Posts extends Table {
    protected $order_by = '`created` DESC';
    protected $meta = array(
        'columns' => array(
            'user_id' => array(
                'type' => 'foreign_key',
                'table' => 'Users',
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
                    'DRAFT'     => 'Draft',
                    'PUBLISHED' => 'Published',
                    'DELETED'   => 'Deleted',
                ),
            ),
            'tags' => array(
                'type' => 'text',
            ),
        ),
    );

    /**
     * because so much of these functions are front-end specific, a status of PUBLISH
     * is implicitly assumed unless specifically EXCLUDED in the method name
     */
    public function findRecent($x = 10) {
        $date = Utils::getDate("Y-m-d H:i:s");
        return $this->findAll("`status` = ? AND `published` <= ?", array("PUBLISHED", $date), null, $x);
    }

    public function findByMonthAndUrl($month, $url) {
        $month = str_replace("/", "-", $month);
        $date = Utils::getDate("Y-m-d H:i:s");
        return $this->find("`published` <= ? AND `published` LIKE ? AND `url` = ? AND `status` = ?", array(
            $date,
            "{$month}%",
            $url,
            "PUBLISHED",
        ));
    }

    public function findAllForTag($tag) {
        $date = Utils::getDate("Y-m-d H:i:s");
        $sql = "`tags` LIKE ? AND `status` = ? AND `published` <= ?";
        $params = array("%|".$tag."|%", "PUBLISHED", $date);

        return $this->findAll($sql, $params);
    }

    public function findAllForTagOrTitle($q, $user_id = null) {
        $date = Utils::getDate("Y-m-d H:i:s");
        $sql = "(`tags` LIKE ? OR `title` LIKE ?) AND `status` = ? AND `published` <= ?";
        $params = array("%|".$q."|%", "%".$q."%", "PUBLISHED", $date);

        return $this->findAll($sql, $params);
    }
    
    public function findMonthsWithPublishedPosts() {
        $date = Utils::getDate("Y-m-d H:i:s");
        $sql = "SELECT DISTINCT(DATE_FORMAT(p.published, '%Y-%m-01')) FROM `posts` p
        WHERE `p`.`status` = ? AND `p`.`published` <= ?
        ORDER BY `p`.`created` DESC";

        $params = array("PUBLISHED", $date);

	$dbh = Db::getInstance();
	$sth = $dbh->prepare($sql);
        $sth->execute($params);
        $items = $sth->fetchAll(PDO::FETCH_NUM);
        $final = array();
        foreach ($items as $item) {
            $final[] = $item[0];
        }
        return $final;
    }

    // @todo while tags are stored in their current format,
    // this function is always going to be a bit too PHP heavy...
    public function findAllTags() {
        $date = Utils::getDate("Y-m-d H:i:s");
        $sql = "SELECT `tags` FROM `posts` p
        WHERE `p`.`status` = ? AND `p`.`published` <= ?";

        $params = array("PUBLISHED", $date);

	$dbh = Db::getInstance();
	$sth = $dbh->prepare($sql);
        $sth->execute($params);
        $items = $sth->fetchAll(PDO::FETCH_NUM);
        $final = array();
        foreach ($items as $item) {
            $tags = Post::convertTagsToArray($item[0]);
            $final = array_merge($final, $tags);
        }
        $tags = array_unique($final);

        natcasesort($tags);
        return $tags;
    }
    
    public function findAllForMonth($month) {
        $month = str_replace("/", "-", $month);
        $date = Utils::getDate("Y-m-d H:i:s");
        return $this->findAll("`published` <= ? AND `published` LIKE ? AND `status` = ?", array(
            $date,
            "{$month}%",
            "PUBLISHED",
        ));
    }
}
