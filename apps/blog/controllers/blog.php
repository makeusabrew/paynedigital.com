<?php
class BlogController extends Controller {
    public function view_post() {
        $post = Table::factory('Posts')->findByMonthAndUrl(
            $this->getMatch('month'),
            $this->getMatch('url')
        );
        if ($post == false) {
            throw new CoreException('No matching blog post found', CoreException::PATH_REJECTED);
        }
        $this->assign('post', $post);
        $this->assign('comments', $post->getApprovedComments());

        // get the fields for comments
        $this->assign('columns', Table::factory('Comments')->getColumns());
    }
}
