<?php
class BlogController extends Controller {
    public function index() {
        $posts = Table::factory('Posts')->findRecentPublished(4);
        $this->assign('posts', $posts);
    }
}
