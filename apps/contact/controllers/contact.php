<?php

class ContactController extends Controller {
    public function index() {
        $this->assign("columns", Table::factory('Contacts')->getColumns());
        if ($this->request->isPost()) {
            $contact = Table::factory('Contacts')->newObject();
            if ($contact->setValues($this->request->getPost())) {
                // all good. add, and stuff
                $contact->save();
                $this->setFlash("contact_thanks");
                return $this->redirectAction("thanks");
            } else {
                $this->setErrors($contact->getErrors());
            }
        }
    }

    public function thanks() {
        if ($this->getFlash("contact_thanks") === null) {
            return $this->redirect("/");
        }
    }
}
