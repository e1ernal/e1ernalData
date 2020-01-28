//
//  AnimationTextField.swift
//  MainTask
//
//  Created by кирилл корнющенков on 18.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import Foundation
import UIKit

class AnimationTextField: UITextField{
    
    func animation(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 10
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        self.text = nil
    }
}
