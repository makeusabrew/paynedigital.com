<?php
class AdminController extends Controller {
    protected $adminUser = null;
    protected $post = null;

    public function init() {
        $this->adminUser = Table::factory('Users')->loadFromSession();
        $this->assign('adminUser', $this->adminUser);
        switch ($this->path->getAction()) {
            case "login":
                if ($this->adminUser->isAuthed() == true) {
                    $this->redirectAction("index");
                    throw new CoreException("Already Authed");
                }
                break;
            default:
                if ($this->adminUser->isAuthed() == false) {
                    $this->redirectAction("login");
                    throw new CoreException("Not Authed");
                }
                break;
        }
        if ($this->getMatch('id') !== null) {
            $post = Table::factory('Posts')->read($this->getMatch('id'));
            if ($post == false || $this->adminUser->owns($post) == false) {
                $this->redirectAction("index", "You cannot perform this action");
                throw new CoreException("You cannot perform this action");
            }
            $this->post = $post;
        }
    }

    public function login() {
        $this->assign('columns', Table::factory('Users')->getColumns());
        if ($this->request->isPost()) {
            $user = Table::factory('Users')->login(
                $this->request->getVar('email'),
                $this->request->getVar('password')
            );
            if ($user) {
                $user->addToSession();
                return $this->redirectAction("index");
            }
            // tut tut
            Log::warn("Invalid admin login attempt from IP [".$this->request->getIp()."] for email [".$this->request->getVar('email')."]");
            $this->addError('Invalid login details');
        }
    }

    public function logout() {
        $this->adminUser->logout();
        return $this->redirectAction("login");
    }

    public function index() {
        $this->assign('posts', $this->adminUser->getAllPosts());
    }

    public function edit_post() {
        $this->assign('object', $this->post);
        $this->assign('columns', $this->post->getColumns());
        if ($this->request->isPost()) {
            $data = array(
                "title" => $this->request->getVar('title'),
                "url" => $this->request->getVar('url'),
                "status" => $this->request->getVar('status'),
                "published" => $this->request->getVar('published'),
                "content" => $this->request->getVar('content'),
                "tags" => $this->request->getVar('tags'),
                "head_block" => $this->request->getVar('head_block'),
                "script_block" => $this->request->getVar('script_block'),
            );
            if ($this->post->updateValues($data)) {
                $this->post->save();
                return $this->redirectAction("index", "Post updated");
            }
            $this->setErrors($this->post->getErrors());
        }
    }

    public function add_post() {
        $this->assign('columns', Table::factory('Posts')->getColumns());
        // for now we can safely just piggy back off the edit post
        // this might need to change in future
        if ($this->request->isPost()) {
            $data = array(
                "title" => $this->request->getVar('title'),
                "url" => $this->request->getVar('url'),
                "status" => $this->request->getVar('status'),
                "published" => $this->request->getVar('published'),
                "content" => $this->request->getVar('content'),
                "tags" => $this->request->getVar('tags'),
                "user_id" => $this->adminUser->getId(),
                "head_block" => $this->request->getVar('head_block'),
                "script_block" => $this->request->getVar('script_block'),
            );
            $post = Table::factory('Posts')->newObject();
            if ($post->setValues($data)) {
                $post->save();
                return $this->redirectAction("index", "Post created");
            }
            $this->setErrors($post->getErrors());
        }
        return $this->render("edit_post");
    }

    public function generate_burn_link() {
        $preview = Table::factory('Previews')->newObject();
        $data = array(
            "post_id"  => $this->post->getId(),
            "user_id"  => $this->adminUser->getId(),
            "quantity" => 1,
        );
        if ($preview->setValues($data)) {
            $preview->setUniqueIdentifier();
            $preview->save();
            $identifier = Settings::getValue("site.base_href")."/burn-after-reading/".$preview->identifier;
            $this->assign("identifier", $identifier);
        }
    }

    public function view_comments() {
        $this->assign('comments', $this->post->getComments());
        $this->assign('columns', Table::factory('Comments')->getColumns());
    }

    public function edit_comment() {
        $comment = Table::factory('Comments')->read($this->getMatch('comment_id'));
        if ($comment == false || $comment->post_id != $this->post->getId()) {
            return $this->redirectAction("index", "You cannot perform this action");
        }

        $notApprovedBefore = $comment->hasNeverBeenApproved();

        if ($comment->updateValues($this->request->getPost(), true)) {
            if ($notApprovedBefore &&
                $comment->approved) {
                // new approval
                $comment->approved_at = Utils::getDate("Y-m-d H:i:s");
                if ($comment->emailOnApproval()) {
                    // bosh!
                    $from = Settings::getValue("contact.from_address");
                    $subject = "Your comment has been approved";
                    $to = $comment->name." <".$comment->email.">";
                    $email = Email::factory();
                    $email->setFrom($from);
                    $email->setTo($to);
                    $email->setSubject($subject);
                    $email->setBodyFromTemplate("emails/comment-approved", array(
                        "post"    => $this->post,
                        "comment" => $comment,
                    ));
                    $email->send();

                }

                $comments = Table::factory('Comments')->findOthersForPost($this->post->getId(), $comment->getId());
                $sentEmails = array();
                foreach ($comments as $otherComment) {
                    if ($otherComment->emailOnNew()) {
                        $to = $otherComment->name." <".$otherComment->email.">";
                        if (isset($sentEmails[$to])) {
                            Log::warn("New comment notification email already sent to [".$to."]");
                            continue;
                        }
                        $from = Settings::getValue("contact.from_address");
                        $subject = "A new comment has been added";
                        $email = Email::factory();
                        $email->setFrom($from);
                        $email->setTo($to);
                        $email->setSubject($subject);
                        $email->setBodyFromTemplate("blog/views/emails/new-comment", array(
                            "post"    => $this->post,
                            "comment" => $otherComment,
                            "unsubscribe_hash" => $otherComment->getUnsubscribeHash(),
                        ));
                        $email->send();
                        $sentEmails[$to] = true;
                    }
                }
            }
            $comment->save();
            return $this->redirectAction("index", "Comment Updated");
        }
        $this->setErrors($comment->getErrors());
    }
}
