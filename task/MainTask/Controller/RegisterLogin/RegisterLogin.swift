//
//  ViewController.swift
//  MainTask
//
//  Created by кирилл корнющенков on 02.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterLogin: UIViewController{
    
    @IBOutlet weak var bestView: UIView!
    var errorLabel = UILabel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var singup:Bool = true{
        willSet{
            if newValue{
                loginField.isHidden = false
                enterButton.setTitle("Зарегистрироваться", for: .normal)
            }else{
                loginField.isHidden = true
                enterButton.setTitle("Войти", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var passwordField: AnimationTextField!
    @IBOutlet weak var emailField: AnimationTextField!
    @IBOutlet weak var loginField: AnimationTextField!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    @objc func didTapView(gesture:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification:notification)
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            self.keyboardWillHide(notification:notification)
        }
    }
    
    func keyboardWillShow(notification: Notification){
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification){
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        singup = !singup
    }
    
    //Кнопка входа
    @IBAction func GoButton(_ sender: UIButton) {
        let password = passwordField.text!
        let email = emailField.text!
        let login = loginField.text!
        if (singup){
            if(!password.isEmpty && !email.isEmpty && !login.isEmpty){
                Auth.auth().createUser(withEmail: email, password: password) { [weak self](result, error) in
                    if error == nil{
                        if let result = result{
                            let ref = Database.database().reference().child("users")
                            //ref.child(result.user.uid).updateChildValues(["login":login,"email":email])
                            //MARK: test block
                            ref.child(result.user.uid).setValue(["login":login,"email":email,"id": result.user.uid]) {
                              (error:Error?, ref:DatabaseReference) in
                              if let error = error {
                                print("Data could not be saved: \(error).")
                              } else {
                                print("Data saved successfully!")
                              }
                            }
                            //MARK: end block
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }else{
                        self?.emailField.animation()
                        self?.loginField.animation()
                        self?.passwordField.animation()
                        //print(error)
                    }
                }
            }else{
                errorAlert()
            }
        }else{
            if(!email.isEmpty && !password.isEmpty){
                Auth.auth().signIn(withEmail: email, password: password) { [weak self](result, error) in
                    if error == nil{
                        self?.dismiss(animated: true, completion: nil)
                    }else{
                        //print(error)
                        self?.emailField.animation()
                        self?.passwordField.animation()
                       // self?.label()
                    }
                }
            }else{
                errorAlert()
            }
        }
    }
    
    func label(){
        errorLabel = UILabel(frame: CGRect(x: 70, y: emailField.frame.width + 1, width:emailField.frame.width, height: 8))
        errorLabel.font = UIFont.boldSystemFont(ofSize: 10)
        errorLabel.text = "error data"
        errorLabel.textAlignment = .center
        bestView.addSubview(errorLabel)
    }
    
    //MARK: alert, если какое-то из полей ввода пустое
    func errorAlert(){
    }

}
