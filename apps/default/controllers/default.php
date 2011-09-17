<?php
class DefaultController extends Controller {
    public function index() {
        $posts = Table::factory('Posts')->findRecent(3);
        $this->assign('posts', $posts);

        $archive = Table::factory('Posts')->findMonthsWithPublishedPosts();
        $this->assign('archive', $archive);
    }

    public function view_static() {
        try {
            return $this->renderStatic($this->getMatch('path'));
        } catch (CoreException $e) {
            // no static, oh well. Reject the path
            throw new CoreException("Path Rejected", CoreException::PATH_REJECTED);
        }
    }
}
