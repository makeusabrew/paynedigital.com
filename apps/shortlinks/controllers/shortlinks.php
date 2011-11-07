<?php

class ShortlinksController extends Controller {
    public function bootbox_redirect() {
        return $this->redirect(array(
            "app"        => "blog",
            "controller" => "Blog",
            "action"     => "view_post",
            "month"      => "2011/11",
            "url"        => "bootbox-js-alert-confirm-dialogs-for-twitter-bootstrap",
        ));
    }
}
