<?php

class FeedController extends Controller {

    public function index() {
        $articles = Table::factory('Posts')->findRecent();
        $this->assign('articles', $articles);
        $this->response->addHeader('Content-Type', 'application/xml; charset=utf-8'); 
    }

}
