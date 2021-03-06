<?php

class Post extends Object {
    public function getTweetUrl() {
        $legacyDate = strtotime("2013-03-01 00:00:00");

        if (strtotime($this->published) < $legacyDate) {
            return $this->getUrl();
        }

        return "articles/".$this->getUrl();
    }

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

    public function commentsEnabled() {
        return !!$this->comments_enabled;
    }

    public function getPublishedRelatedPostsCount() {
        return count(
            $this->getPublishedRelatedPosts()
        );
    }

    public function getPublishedRelatedPosts() {
        return Table::factory('Posts')->findAllPublishedAndRelatedForPost($this->getId());
    }

    public function getUnpublishedRelatedPostsCount() {
        return count(
            $this->getUnpublishedRelatedPosts()
        );
    }

    public function getUnpublishedRelatedPosts() {
        return Table::factory('Posts')->findAllUnpublishedAndRelatedForPost($this->getId());
    }

    public function getRelatedPosts() {
        return Table::factory('RelatedPosts')->findAll(array(
            "post_id" => $this->getId(),
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

    public function formatTagLabel($str) {
        return strtolower(str_replace(array(
            " ",
            ".",
        ),
        array(
            "_",
            "_",
        ),
        $str));
    }

    public function getWordCount() {
        $content = strip_tags($this->content);
        $count = str_word_count($content);
        return number_format($count);
    }
}

class Posts extends Table {
    protected $order_by = '`published` DESC';
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
            'introduction' => array(
                'type' => 'textarea',
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
            'head_block' => array(
                'type' => 'textarea',
                'required' => false,
                'title' => 'Head Block',
            ),
            'script_block' => array(
                'type' => 'textarea',
                'required' => false,
                'title' => 'Script Block',
            ),
            'comments_enabled' => array(
                'type' => 'bool',
                'title' => 'Comments Enabled?',
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
        ORDER BY `p`.`published` DESC";

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

    public function findAllPublishedAndRelatedForPost($post_id) {
        return $this->findAllRelatedForPost($post_id, true);
    }

    public function findAllUnpublishedAndRelatedForPost($post_id) {
        return $this->findAllRelatedForPost($post_id, false);
    }

    public function findAllRelatedForPost($post_id, $published) {
        $params = array($post_id);

        $sql = "SELECT title,published,url FROM `posts` p
            INNER JOIN (`related_posts` rp) ON (rp.related_post_id=p.id) 
            WHERE rp.post_id = ?";

        if ($published !== null) {
            if ($published === true) {
                $sql .= " AND `published` <= ? AND `status` = ?";
            } else {
                $sql .= " AND (`published` > ? OR `status` <> ?)";
            }
            $params[] = Utils::getDate("Y-m-d H:i:s");
            $params[] = "PUBLISHED";
        }
        $sql.= " ORDER BY rp.sort_order ASC";

        $dbh = Db::getInstance();
        $sth = $dbh->prepare($sql);
        $sth->setFetchMode(PDO::FETCH_CLASS, "Post");
        $sth->execute($params);
        return $sth->fetchAll();
    }
}
