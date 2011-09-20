<?php
class AdminController extends Controller {
    protected $adminUser = null;

    public function init() {
        $this->adminUser = Table::factory('Users')->loadFromSession();
        $this->assign('adminUser', $this->adminUser);
        switch ($this->path->getAction()) {
            case "index":
                if ($this->adminUser->isAuthed() == false) {
                    $this->redirectAction("login");
                    throw new CoreException("Not Authed");
                }
                break;
            default:
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
            if ($post->setValues($data)) {
                $post->save();
                return $this->redirectAction("index", "Post updated");
            }
            $this->setErrors($post->getErrors());
        }
    }
}
