<?php

class ContactController extends AbstractController {
    public function index() {
        if ($this->request->isGet()) {
            $this->assign("columns", Table::factory('Contacts')->getColumns());
        }
        if ($this->request->isPost()) {
            $contact = Table::factory('Contacts')->newObject();
            if ($contact->setValues($this->request->getPost())) {
                // all good. add, and stuff
                $contact->save();

                $address = Settings::getValue("contact.address");
                $subject = "Enquiry via paynedigital.com";
                $from = $contact->name." <".$contact->email.">";
                $email = Email::factory();
                $email->setFrom($from);
                $email->setTo($address);
                $email->setSubject($subject);
                $email->setBody(
                    $this->fetchTemplate("emails/contact", array(
                        "query" => $contact->content,
                        "name" => $contact->name,
                    ))
                );
                $email->send();

                if (!$this->request->isAjax()) {
                    $this->setFlash("contact_thanks");
                    return $this->redirectAction("thanks");
                }
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
