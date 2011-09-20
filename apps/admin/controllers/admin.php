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
    }
}
