//
//  ViewController.swift
//  calculator
//
//  Created by Vladyslav FIL on 04.03.19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    class Calculator {
        var displayValue: String = "0"
        var firstOperand: Double = 0
        var secondOperand: Double?
        var waitingForSecondOperand = false
        var currentOperator: String = ""
        var displayedOperand: Int = 1
        
        let nanText: String = "Not a number"

        func formatDisplay(value: Double) -> String {
            return String(value.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", value) : String(value))
        }
        
        func compute() {
            if self.secondOperand == nil {
                self.secondOperand = self.firstOperand
            }
            
            switch self.currentOperator {
            case "/":
                if self.secondOperand == 0 {
                    self.displayValue = self.nanText
                    self.waitingForSecondOperand = false
                    return
                }
                self.firstOperand /= self.secondOperand!
            case "*":
                self.firstOperand *= self.secondOperand!
            case "-":
                self.firstOperand -= self.secondOperand!
            case "+":
                self.firstOperand += self.secondOperand!
            default: break
            }
            self.displayValue = self.formatDisplay(value: self.firstOperand)
            self.displayedOperand = 1
        }
        
        func reset() {
            self.displayValue = "0"
            self.firstOperand = 0
            self.secondOperand = 0
            self.waitingForSecondOperand = false
            self.currentOperator = ""
        }
        
        func updateDisplay(dispLabel: UILabel ) {
            dispLabel.text = self.displayValue
        }
        
        func printTitle(buttonObj: UIButton) {
            print("\(buttonObj.titleLabel!.text!) button pressed.")
        }
        
        func printDebugInfo() {
            print("Display value: \(self.displayValue)")
            print("First Operand: \(self.firstOperand)")
            print("Current operator: \(self.currentOperator)")
            print("Second Operand: \(self.secondOperand ?? 0)\n")
        }
    }

    let calculator = Calculator()
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        calculator.updateDisplay(dispLabel: displayLabel)
        displayLabel.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushNumber(_ sender: UIButton) {
        let numberText: String = sender.titleLabel!.text!
        
        if calculator.displayValue != "0" && calculator.displayValue != calculator.nanText {
            calculator.displayValue.append(numberText)
        } else {
            calculator.displayValue = numberText
        }
        
        if !calculator.waitingForSecondOperand {
            calculator.firstOperand = Double(calculator.displayValue)!
        } else {
            calculator.secondOperand = Double(calculator.displayValue)!
        }
        
        calculator.updateDisplay(dispLabel: displayLabel)
        calculator.printTitle(buttonObj: sender)
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        calculator.reset()
        calculator.updateDisplay(dispLabel: displayLabel)
        calculator.printTitle(buttonObj: sender)
    }
    
    @IBAction func operatorButton(_ sender: UIButton) {
        if calculator.currentOperator != "" {
            calculator.compute()
            calculator.updateDisplay(dispLabel: displayLabel)
        }
        calculator.currentOperator = sender.titleLabel!.text!
        calculator.waitingForSecondOperand = true
        calculator.displayedOperand = 2
        calculator.displayValue = "0"
        calculator.printTitle(buttonObj: sender)
    }
    
    @IBAction func computeButton(_ sender: UIButton) {
        calculator.compute()
        calculator.updateDisplay(dispLabel: displayLabel)
        calculator.printTitle(buttonObj: sender)
        calculator.printDebugInfo()
    }
    
    @IBAction func negButton(_ sender: UIButton) {
        if calculator.displayedOperand == 1 {
            calculator.firstOperand = calculator.firstOperand != 0 ? calculator.firstOperand * -1 : calculator.firstOperand
            calculator.displayValue = calculator.formatDisplay(value: calculator.firstOperand)
        } else {
            calculator.secondOperand! = calculator.secondOperand! != 0 ? calculator.secondOperand! * -1 : calculator.secondOperand!
            calculator.displayValue = calculator.formatDisplay(value: calculator.secondOperand!)
        }
        calculator.printTitle(buttonObj: sender)
        calculator.updateDisplay(dispLabel: displayLabel)
    }
}

