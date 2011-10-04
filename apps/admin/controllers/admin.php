<?php
class AdminController extends Controller {
    protected $adminUser = null;

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
        $post = Table::factory('Posts')->read($this->getMatch('id'));
        if ($post == false || $this->adminUser->owns($post) == false) {
            return $this->redirectAction("index", "You cannot edit this post");
        }
        $this->assign('object', $post);
        $this->assign('columns', $post->getColumns());
        if ($this->request->isPost()) {
            $data = array(
                "title" => $this->request->getVar('title'),
                "url" => $this->request->getVar('url'),
                "status" => $this->request->getVar('status'),
                "published" => $this->request->getVar('published'),
                "content" => $this->request->getVar('content'),
                "tags" => $this->request->getVar('tags'),
            );
            if ($post->updateValues($data)) {
                $post->save();
                return $this->redirectAction("index", "Post updated");
            }
            $this->setErrors($post->getErrors());
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
                "user_id" => $this->adminUser->getId()
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
        $post = Table::factory('Posts')->read($this->getMatch('id'));
        if ($post == false || $this->adminUser->owns($post) == false) {
            return $this->redirectAction("index", "You cannot perform this action");
        }
        $preview = Table::factory('Previews')->newObject();
        $data = array(
            "post_id"  => $post->getId(),
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
}
