//
//  jsonAllLogin.swift
//  MainTask
//
//  Created by кирилл корнющенков on 09.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import Foundation
import Firebase

struct jsonAllLogin{
    var login:String
    var email:String
    var id:String
    init(snapshot:DataSnapshot){
        let snapshotValue = snapshot.value as! [String:AnyObject]
        self.login = snapshotValue["login"] as! String
        self.email = snapshotValue["email"] as! String
        self.id = snapshotValue["id"] as! String
    }
}

struct allTaskStruct {
    var topic:String
    init(snapshot:DataSnapshot){
        let snapshotValue = snapshot.value as! [String:AnyObject]
        self.topic = snapshotValue["topic"] as! String
    }
}

struct Worker {
    let email:String
    let login:String

    init(snapshot:DataSnapshot){
        let snapshotValue = snapshot.value as! [String:AnyObject]
        self.login = snapshotValue["login"] as! String
        self.email = snapshotValue["email"] as! String
    }
}
