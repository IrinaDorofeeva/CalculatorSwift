//
//  ViewController.swift
//  Calculator
//
//  Created by Mac on 12/27/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var display: UILabel!
    
    fileprivate var userInTheMiddleOfTyping = false
    
    
    
    
    
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        
        
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping {
            let textCurrentlyInDispay = display.text!
            display.text = textCurrentlyInDispay + digit
        }
        else{
            display.text = digit
            
        }
        userInTheMiddleOfTyping = true
    }
    
     //get and set value on dispaly without always writting convertion
    
    fileprivate var displayValue: Double{
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        
       
        
        if userInTheMiddleOfTyping {
            
            brain.setOperand(displayValue) //accumulator = dispalyvalue
            
            userInTheMiddleOfTyping = false
        }
        
        
        
        if let mathematicalSymbol = sender.currentTitle {
            
            brain.performOperation(mathematicalSymbol)
            
        }
        displayValue = brain.result
    }
    
}

