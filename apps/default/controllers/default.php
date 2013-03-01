<?php
class DefaultController extends Controller {
    public function index() {
        $posts = Table::factory('Posts')->findRecent(3);
        $this->assign('posts', $posts);

        $archive = Table::factory('Posts')->findMonthsWithPublishedPosts();
        $this->assign('archive', $archive);
        $this->assign('section', 'home');
    }

    public function handleError($e, $code) {
        $this->assign('section', 'error');
        $this->assign("code", $code);
        return $this->render("error");
    }
}
