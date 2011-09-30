<?php
class BlogController extends Controller {
    protected $post = null;

    public function init() {
        if (($post_id = $this->getFlash("preview_post_id")) !== null) {
            Log::debug("Got preview post ID [".$post_id."]");
            $post = Table::factory('Posts')->read($post_id);
            if ($post == false) {
                throw new CoreException('No matching blog post found to preview', CoreException::PATH_REJECTED);
            }

            // we need to explicitly opt out of caching as this should be a one-time only link
            Log::info("Disabling cache for one-time blog post viewing");
            $this->request->disableCache();
        } else if ($this->getMatch('month') && $this->getMatch('url')) {
            $post = Table::factory('Posts')->findByMonthAndUrl(
                $this->getMatch('month'),
                $this->getMatch('url')
            );
            if ($post == false) {
                throw new CoreException('No matching blog post found', CoreException::PATH_REJECTED);
            }
        }

        if (isset($post) && is_object($post)) {
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

    public function burn_after_reading() {
        $preview = Table::factory('Previews')->findRedeemableByIdentifier($this->getMatch('identifier'));
        if ($preview == false) {
            throw new CoreException('No valid preview found', CoreException::PATH_REJECTED);
        }
        $post = Table::factory('Posts')->read($preview->post_id);
        if ($post == false) {
            Log::warn("no post found for preview ID [".$preview->getId()."]");
            throw new CoreException('No matching blog post found', CoreException::PATH_REJECTED);
        }
        Log::debug("Redeeming preview ID [".$preview->getId()."] quanity [".$preview->quantity."] post ID [".$post->getId()."]");
        $preview->redeem();
        $preview->save();

        $this->setFlash("preview_post_id", $post->getId());
        return $this->redirect("/".$post->getUrl());
    }
}
