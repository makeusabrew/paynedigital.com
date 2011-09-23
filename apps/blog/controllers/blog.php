<?php
class BlogController extends Controller {
    protected $post = null;

    public function init() {
        if ($this->getMatch('month') && $this->getMatch('url')) {
            $post = Table::factory('Posts')->findByMonthAndUrl(
                $this->getMatch('month'),
                $this->getMatch('url')
            );
            if ($post == false) {
                throw new CoreException('No matching blog post found', CoreException::PATH_REJECTED);
            }
            $this->post = $post;
            $this->assign('post', $this->post);
            $this->assign('comments', $post->getApprovedComments());

            // get the fields for comments
            $this->assign('columns', Table::factory('Comments')->getColumns());
        }
    }

    public function index() {
        $archive = Table::factory('Posts')->findMonthsWithPublishedPosts();
        $this->assign('archive', $archive);

        $this->assign('tags', Table::factory('Posts')->findAllTags());
    }

    public function view_post() {
        // init will do
    }

    public function add_comment() {
        if (!$this->request->isPost()) {
            return $this->redirect("/");
        }

        $comment = Table::factory('Comments')->newObject();
        $name = ($this->request->getVar("name") != "") ? $this->request->getVar("name") : "Anonymous";
        $data = array(
            "post_id" => $this->post->getId(),
            "name"  => $name,
            "email" => $this->request->getVar("email"),
            "content" => $this->request->getVar("content"),
            "approved" => false,
            "ip" => $this->request->getIp(),
        );
        if ($comment->setValues($data)) {
            $comment->save();

            $address = Settings::getValue("contact.address");
            $subject = "New comment submission (paynedigital.com)";
            $from = $comment->name." <".$comment->email.">";
            $email = Email::factory();
            $email->setFrom($from);
            $email->setTo($address);
            $email->setSubject($subject);
            $email->setBodyFromTemplate("emails/comment", array(
                "post"    => $this->post,
                "comment" => $comment,
            ));
            $email->send();

            if (!$this->request->isAjax()) {
                $this->setFlash("comment_thanks");
                return $this->redirect("/".$this->post->getUrl()."/comment/thanks#comments");
            }
        } else {
            $this->setErrors($comment->getErrors());
        }
        return $this->render("view_post");
    }

    public function comment_thanks() {
        if ($this->getFlash("comment_thanks") === null) {
            Log::debug("comment thanks URL accessed with no flash var");
            return $this->redirect("/");
        }
        $this->assign('comment_submitted', true);
        return $this->render("view_post");
    }

    public function search_tags() {
        $posts = Table::factory('Posts')->findAllForTag($this->getMatch('tag'));
        $this->assign('search_tag', $this->getMatch('tag'));
        $this->assign('posts', $posts);
    }

    public function view_month() {
        $posts = Table::factory('Posts')->findAllForMonth($this->getMatch('month'));
        $this->assign('posts', $posts);
        $this->assign('month', str_replace("/", "-", $this->getMatch('month'))."-01");
    }
}
