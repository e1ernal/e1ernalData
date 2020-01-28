//
//  infoView.swift
//  MainTask
//
//  Created by DMITRY on 08/01/2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import Firebase

class infoView: UIViewController {
    var ref: DatabaseReference!
    
    @IBOutlet weak var nameLabel: UILabel!
    //grad settings
    var backView: CAGradientLayer!{
        didSet{
            backView.startPoint = CGPoint(x: 0, y: 0)
            backView.endPoint = CGPoint(x: 0, y: 1)
            let startColor = #colorLiteral(red: 0.4509803922, green: 0.5764705882, blue: 0.6235294118, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            backView.colors = [startColor,endColor]
        }
    }
    
    @IBOutlet weak var imagePeople: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSetting(sender: imagePeople)
        ref = Database.database().reference()
        //grad add
        backView = CAGradientLayer()
        view.layer.insertSublayer(backView, at: 0)
    }
    
    //grad size
    override func viewDidLayoutSubviews() {
        backView.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: 200)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage()
        jsonReadData()
    }
    
    //считывание нужных данных
    func jsonReadData(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [weak self](snapshot) in
          // Get user value
            let value = snapshot.value as? NSDictionary
            let login = value?["login"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let soname = value?["soname"] as? String ?? ""
            self?.nameLabel.text = name + " " + soname
            self?.loginLabel.text = "@\(login)"
            self?.emailLabel.text = email
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func imageSetting(sender:UIImageView){
        sender.layer.cornerRadius = sender.frame.width / 2
        sender.clipsToBounds = true
    }
    
    func loginReturn()->String{
       let user = Auth.auth().currentUser?.uid
       return user!
    }
    
    func loadImage(){
        let storageRef = Storage.storage().reference(withPath: "imagePeople/\(loginReturn()).jpg")
        storageRef.getData(maxSize: 4 * 1024 * 1024) { [weak self] (data, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
              self?.imagePeople.image = UIImage(data: data)
            }
        }
    }
    
    //выход из приложения
    @IBAction func exitButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let registerLogin = storyboard?.instantiateViewController(withIdentifier: "RegisterLogin") as! RegisterLogin
        self.present(registerLogin,animated: true,completion: nil)
    }
}
