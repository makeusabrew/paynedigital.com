<?php

class SearchController extends Controller {
    public function index() {
        $posts = Table::factory('Posts')->findAllForTagOrTitle($this->request->getVar('q'));
        $this->assign('search_query', $this->request->getVar('q'));
        $this->assign('posts', $posts);
    }
}
