<?php
class DefaultController extends AbstractController {
    public function index() {
    }

    public function handleError($e, $code) {
        $this->assign("code", $code);
        return $this->render("error");
    }

    public function process() {
        $data = $this->request->getVar("src");
        $degrees = rand(0, 359);
        $image = imagecreatefromstring($data);
        $rotated = imagerotate($image, $degrees, 0);

        imagejpeg($rotated, "/tmp/image.jpg");

        imagedestroy($image);
        imagedestroy($rotated);

        $string = file_get_contents("/tmp/image.jpg");

        $this->response->addHeader("Content-Type", "image/jpeg");
        $this->response->setBody($string);
    }
}
