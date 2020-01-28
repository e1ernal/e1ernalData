//
//  aboutPeople.swift
//  MainTask
//
//  Created by кирилл корнющенков on 11.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import Firebase

class aboutPeople: UIViewController {
    
    @IBOutlet weak var imagePeople: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    var ref: DatabaseReference!
    var id:String = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        jsonReadData()
        loadImage()
        imageSetting(sender: imagePeople)
        //grad add
        backView = CAGradientLayer()
        view.layer.insertSublayer(backView, at: 0)
        // Do any additional setup after loading the view.
    }
    
    func imageSetting(sender:UIImageView){
        sender.layer.cornerRadius = sender.frame.width / 2
        sender.clipsToBounds = true
    }
    
    //считывание нужных данных
    func jsonReadData(){
        ref.child("users").child(id).observeSingleEvent(of: .value, with: { [weak self](snapshot) in
          // Get user value
            let value = snapshot.value as? NSDictionary
            let login = value?["login"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let soname = value?["soname"] as? String ?? ""
            self?.loginLabel.text = login
            self?.emailLabel.text = email
            self?.nameLabel.text = name + " " + soname
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadImage(){
        let storageRef = Storage.storage().reference(withPath: "imagePeople/\(id).jpg")
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
    
    //grad size
    override func viewDidLayoutSubviews() {
        backView.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: 200)
    }
}
