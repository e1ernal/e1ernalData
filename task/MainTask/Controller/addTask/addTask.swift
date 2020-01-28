//
//  addTask.swift
//  MainTask
//
//  Created by кирилл корнющенков on 05.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import Firebase

class addTask: UIViewController {
    
    //массив людей,которым мы добавляем task
    var emailPeopleForTask:[String] = []
    var ref: DatabaseReference!
    var listPeople:[String] = []
    @IBOutlet weak var whoTextField: UITextField!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var contebtTextView: UITextView!
    var date = String()
    var allLoginAndEmailArray:[jsonAllLogin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        jsonLoginAndEmail()
    }
 
    @IBAction func addEmailButton(_ sender: UIButton) {
        alertAddEmail()
    }
    
    func jsonLoginAndEmail(){
        ref.child("users").observe(.value) { [weak self](snapshot) in
            var _arr:[jsonAllLogin] = []
            for item in snapshot.children{
                let data = jsonAllLogin(snapshot: item as! DataSnapshot)
                _arr.append(data)
            }
            self?.allLoginAndEmailArray = _arr
        }
    }
    
    //добавление задач
    @IBAction func addTaskButton(_ sender: UIBarButtonItem) {
        if whoTextField.text != "" && topicTextField.text != "" && contebtTextView.text != "" {
            let list = whoTextField.text!
            let topic = topicTextField.text!
            let content = contebtTextView.text!
            listPeople = list.components(separatedBy: ",")
            var idList = [String]()
            for p in listPeople{
                for b in self.allLoginAndEmailArray{
                    if p == b.email{
                        idList.append(b.id)
                        break
                    }
                }
            }
            for id in idList{
                ref.child("task").child(id).child(topic).setValue(["topic":topic,"content":content,"author":Auth.auth().currentUser?.uid])
            }
            alertGoodAdd()
        }
    }
    
    //MARK: email alert
    private func alertAddEmail(){
        let alert = UIAlertController(title: "Email", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.placeholder = "Email"
        let AddAction = UIAlertAction(title: "Add", style: .default) { [weak alert](a) in
            let email = alert?.textFields?.first?.text ?? ""
            //MARK: проверка имеется ли такой email/login
            if (true){
                //self.peopleTextField.text = self.peopleTextField.text! + ", " + email
                self.emailPeopleForTask.append(email)
            }
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(AddAction)
        alert.addAction(CancelAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    func alertGoodAdd(){
        let alert = UIAlertController(title:nil, message: "Задача добавлена", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert,animated: true,completion: nil)
    }
}

