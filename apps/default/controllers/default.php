<?php
class DefaultController extends Controller {
    public function index() {
        $posts = Table::factory('Posts')->findRecent(4);
        $this->assign('posts', $posts);
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
