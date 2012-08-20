<?php
class AdminController extends Controller {
    protected $adminUser = null;
    protected $post = null;

    public function init() {
        $this->adminUser = Table::factory('Users')->loadFromSession();
        $this->assign('adminUser', $this->adminUser);
        switch ($this->path->getAction()) {
            case "login":
                if ($this->adminUser->isAuthed()) {
                    throw new InitException(
                        $this->redirectAction("index"),
                        "Already Authed"
                    );
                }
                break;
            default:
                if (!$this->adminUser->isAuthed()) {
                    throw new InitException(
                        $this->redirectAction("login"),
                        "Not Authed"
                    );
                }
                break;
        }
        if ($this->getMatch('id') !== null) {
            $post = Table::factory('Posts')->read($this->getMatch('id'));
            if ($post == false || $this->adminUser->owns($post) == false) {
                throw new InitException(
                    $this->redirectAction("index", "You cannot perform this action"),
                    "You cannot perform this action"
                );
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
                StatsD::increment("login.success");
                return $this->redirectAction("index");
            }
            // tut tut
            StatsD::increment("login.failure");
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
                "introduction" => $this->request->getVar('introduction'),
                "content" => $this->request->getVar('content'),
                "tags" => $this->request->getVar('tags'),
                "head_block" => $this->request->getVar('head_block'),
                "script_block" => $this->request->getVar('script_block'),
                "comments_enabled" => $this->request->getVar('comments_enabled'),
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
                "introduction" => $this->request->getVar('introduction'),
                "content" => $this->request->getVar('content'),
                "tags" => $this->request->getVar('tags'),
                "user_id" => $this->adminUser->getId(),
                "head_block" => $this->request->getVar('head_block'),
                "script_block" => $this->request->getVar('script_block'),
                "comments_enabled" => $this->request->getVar('comments_enabled'),
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
            $identifier = Settings::getValue("site.base_href")."burn-after-reading/".$preview->identifier;
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
                $sentEmails = array();

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
                    $email->setBody(
                        $this->fetchTemplate("emails/comment-approved", array(
                            "host"    => Settings::getValue("site.base_href"),  // @see https://projects.paynedigital.com/issues/665
                            "post"    => $this->post,
                            "comment" => $comment,
                        ))
                    );
                    $email->send();

                    // ensure sent emails always contains the one we just sent, in case the same user has added another
                    // email
                    $sentEmails[$to] = true;
                }

                $comments = Table::factory('Comments')->findOthersForPost($this->post->getId(), $comment->getId());

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
                        $email->setBody(
                            $this->fetchTemplate("blog/views/emails/new-comment", array(
                                "host"    => Settings::getValue("site.base_href"),  // @see https://projects.paynedigital.com/issues/665
                                "post"    => $this->post,
                                "comment" => $otherComment,
                                "unsubscribe_hash" => $otherComment->getUnsubscribeHash(),
                            ))
                        );
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

    public function related_posts() {
        $this->assign('related_posts', $this->post->getRelatedPosts());
        $this->assign('columns', Table::factory('RelatedPosts')->getColumns());
    }

    public function add_related_post() {
        $related = Table::factory('RelatedPosts')->newObject();
        $data = array(
            'post_id' => $this->post->getId(),
            'sort_order' => $this->request->getVar('sort_order'),
            'related_post_id' => $this->request->getVar('related_post_id'),
        );

        if ($related->setValues($data)) {
            $related->save();
            return $this->redirectAction("index", "Relation Created");
        }
        $this->setErrors($related->getErrors());
    }

    public function edit_related_post() {
        $related = Table::factory('RelatedPosts')->read($this->getMatch('related_post_id'));
        if ($related == false || $related->post_id != $this->post->getId()) {
            return $this->redirectAction("index", "You cannot perform this action");
        }
        $data = array(
            'sort_order' => $this->request->getVar('sort_order'),
            'related_post_id' => $this->request->getVar('related_post_id'),
        );

        if ($related->updateValues($data, true)) {
            $related->save();
            return $this->redirectAction("index", "Relation Updated");
        }
        $this->setErrors($related->getErrors());
    }

    public function delete_related_post() {
        $related = Table::factory('RelatedPosts')->read($this->getMatch('related_post_id'));
        if ($related == false || $related->post_id != $this->post->getId()) {
            return $this->redirectAction("index", "You cannot perform this action");
        }
        $related->delete();
        return $this->redirectAction("index", "Relation Deleted");
    }
}
