//
//  Ex02ViewController.swift
//  D00
//
//  Created by Alina FESYK on 1/14/19.
//  Copyright © 2019 Alina FESYK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    var currentInput: Double {
        get {
            if displayResultLabel.text! == "Not a number" {
                return Double.infinity
            }
            return Double(displayResultLabel.text!)!
        }
        set {
            stillTyping = false
            guard !newValue.isInfinite else {
                displayResultLabel.text = "Not a number"
                return
            }
            
            let value = "\(newValue)"
            let valArray = value.components(separatedBy: ".")
            if valArray[1] == "0" {
                displayResultLabel.text = "\(valArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.titleLabel!.text!
        
        if stillTyping {
            if (displayResultLabel.text?.count)! < 19 {
            displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            stillTyping = true
            displayResultLabel.text = number
        }
    }
    
    @IBAction func binaryOperandPressed(_ sender: UIButton) {

        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
    }
    
    func doOperation(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        switch operationSign {
        case "+":
            doOperation{$0 + $1}
        case "-":
            doOperation{$0 - $1}
        case "×":
            doOperation{$0 * $1}
        case "÷":
            doOperation{$0 / $1}
        default: break
        }
        stillTyping = false
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        operationSign = ""
    }
    
    @IBAction func negativeButtonPressed(_ sender: UIButton) {
        if displayResultLabel.text != "0" {
            currentInput = -currentInput
        }
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput /= 100
        } else {
            secondOperand = firstOperand / 100 * currentInput
            currentInput = secondOperand
        }
        stillTyping = false
    }
    
    
    
    
    

}

