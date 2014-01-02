<?php

class AbstractController extends Controller {
    public function init() {
        $append = trim(file_get_contents(PROJECT_ROOT.".append"));
        $this->assign('assetPath', $append);

        $section = null;
        $segments = explode("/", $this->request->getUrl());
        if (count($segments) > 1) {
            $section = $segments[1];
        }
        $this->assign('section', $section);
        $this->assign('static_path', Settings::getValue("site.static_path"));
    }
}
