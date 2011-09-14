<?php
class BlogController extends Controller {
    public function index() {
        $posts = Table::factory('Posts')->findRecent(4);
        $this->assign('posts', $posts);
    }

    public function view_post() {
        $post = Table::factory('Posts')->findByMonthAndUrl(
            $this->getMatch('month'),
            $this->getMatch('url')
        );
        if ($post == false) {
            throw new CoreException('No matching blog post found', CoreException::PATH_REJECTED);
        }
        $this->assign('post', $post);
    }
}
