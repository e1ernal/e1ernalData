//
//  showTask.swift
//  MainTask
//
//  Created by кирилл корнющенков on 06.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import Firebase

class showTask: UIViewController {
    
    var ref: DatabaseReference!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var topic:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = topic
        ref = Database.database().reference()
        jsonReadData()
    }
    
    //считывание нужных данных
    func jsonReadData(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("task").child(userID!).child(topic).observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            let value = snapshot.value as? NSDictionary
            let content = value?["content"] as? String ?? ""
            self?.contentLabel.text = content
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func finishButton(_ sender: UIButton) {
    }
}
