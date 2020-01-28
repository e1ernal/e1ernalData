//
//  jsonData.swift
//  MainTask
//
//  Created by кирилл корнющенков on 09.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import Foundation
import Firebase



struct jsonAllLoginPeople {

    var login:String?
    
    init(snapshot:DataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        login = snapshotValue["login"] as! String
    }
}
