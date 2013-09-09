<?php
class DefaultController extends AbstractController {
    public function index() {
    }

    public function handleError($e, $code) {
        $this->assign("code", $code);
        return $this->render("error");
    }
}
