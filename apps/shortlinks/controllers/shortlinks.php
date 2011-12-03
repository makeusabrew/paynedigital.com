<?php

class ShortlinksController extends Controller {
    public function do_redirect() {
        $link = Table::factory('Shortlinks')->findByUrl($this->getMatch('url'));
        if ($link == null) {
            throw new CoreException('Redirect URL not found', CoreException::PATH_REJECTED);
        }
        return $this->redirect($link->redirect_url);
    }
}
