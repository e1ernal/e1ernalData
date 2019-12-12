//
// Created by DMITRY on 07/12/2019.
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