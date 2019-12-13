//
//  CalculatorViewController.swift
//  Course2Week3Task1
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var firstOperandHeadeLabel: UILabel!
    @IBOutlet weak var secondOperandHeaderLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var firstOperandLabel: UILabel!
    @IBOutlet weak var secondOperandLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var calculateButton: UIButton!
   
    @IBAction func stepperAction(_ sender: UIStepper) {
        firstOperandLabel.text = convert(sender.value, minFractionDigits: 4, maxFractionDigits: 4)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        secondOperandLabel.text = convert(Double(slider.value), minFractionDigits: 4, maxFractionDigits: 4)
    }
        
    @IBAction func calculateAction(_ sender: UIButton) {
        calculate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        firstOperandHeadeLabel.translatesAutoresizingMaskIntoConstraints = false
        firstOperandLabel.translatesAutoresizingMaskIntoConstraints = false
        secondOperandHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        secondOperandLabel.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        stepper.minimumValue = 1.0
        stepper.maximumValue = 10.0
        stepper.stepValue = 0.5
        stepper.value = 0.0
        stepper.tintColor = UIColor(red: CGFloat(236), green: CGFloat(113), blue: CGFloat(73), alpha: 0.9)
        
        slider.minimumValue = 1.0
        slider.maximumValue = 100.0
        slider.value = 0.0
        
        firstOperandLabel.text = convert(stepper.value, minFractionDigits: 4, maxFractionDigits: 4)
        secondOperandLabel.text = convert(Double(slider.value), minFractionDigits: 4, maxFractionDigits: 4)
        calculate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let boundsSize = UIScreen.main.bounds.size
        let size = CGSize(width: boundsSize.width - (Const.smallOffset * 2),
                          height: boundsSize.height - Const.smallOffset - Const.bigOffset)
        
        // result
        resultLabel.frame = CGRect(x: Const.smallOffset,
                                   y: Const.bigOffset,
                                   width: size.width,
                                   height: Const.resultLabelHeight)
        
        // first operand header
        firstOperandHeadeLabel.frame.origin = CGPoint(x: Const.smallOffset,
                                                 y: resultLabel.frame.maxY + Const.bigOffset)
        
        // stepper
        stepper.frame.origin = CGPoint(x: boundsSize.width - Const.smallOffset - stepper.frame.width,
                                       y: firstOperandHeadeLabel.frame.maxY + Const.smallOffset)
        
        // first operand
        let midYStepper = stepper.frame.midY
        firstOperandLabel.frame.origin = CGPoint(x: Const.smallOffset,
                                                 y: midYStepper - (firstOperandHeadeLabel.frame.height / 2))
                
        // second operand header
        secondOperandHeaderLabel.frame.origin = CGPoint(x: Const.smallOffset,
                                                        y: stepper.frame.maxY + Const.bigOffset)
        
        // slider
        slider.frame = CGRect(x: stepper.frame.origin.x,
                              y: secondOperandHeaderLabel.frame.maxY + Const.smallOffset,
                              width: stepper.frame.width,
                              height: stepper.frame.height)
        
        // second operand value
        let midYSlider = slider.frame.midY
        secondOperandLabel.frame.origin = CGPoint(x: Const.smallOffset,
                                                  y: midYSlider - (secondOperandLabel.frame.height / 2))
        
        // calculate button
        calculateButton.frame = CGRect(x: Const.smallOffset,
                                       y: boundsSize.height - Const.calculateButtonHeight - Const.smallOffset,
                                       width: size.width,
                                       height: Const.calculateButtonHeight)
    }
    
    
    private func calculate() {
        let result = stepper.value * Double(slider.value)
        resultLabel.text = convert(result, minFractionDigits: 0, maxFractionDigits: 4)
    }
    
    private func convert(_ value: Double, minFractionDigits: Int, maxFractionDigits: Int) -> String? {
        
        let number = NSNumber(value: value)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = maxFractionDigits
        numberFormatter.minimumFractionDigits = minFractionDigits
        
        return numberFormatter.string(from: number)
    }
}

extension CalculatorViewController {
    
    private enum Const {
        static let smallOffset: CGFloat = 16.0
        static let bigOffset: CGFloat = 32.0
        static let resultLabelHeight: CGFloat = 60.0
        static let calculateButtonHeight: CGFloat = 60.0
    }
}
