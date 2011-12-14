<?php

class FeedController extends Controller {

    public function index() {
        $articles = Table::factory('Posts')->findRecent(5);
        $this->assign('articles', $articles);
        $this->response->addHeader('Content-Type', 'text/xml; charset=utf-8'); 
    }

}
