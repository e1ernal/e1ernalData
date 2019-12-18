//
//  Worker.swift
//  HookahProject
//
//  Created by DMITRY on 14/12/2019.
//  Copyright © 2019 Dmitry Smirnykh. All rights reserved.
//

import Foundation

let currentYear: Int = 2019

class Worker {
    var name: String?
    var position: String?
    var yearOfEmployment: Int?
    init () {
        self.name = ""
        self.position = ""
        self.yearOfEmployment = currentYear
    }
}
