<?php

class AbstractController extends Controller {
    public function init() {
        $assetPaths = array(
            'css' => 'foo', // take a value from settings which is a regex...
            'js'  => 'bar', // ... and run it against getcwd() - maybe??
        );
        $this->assign('assets', $assetPaths);
    }
}
