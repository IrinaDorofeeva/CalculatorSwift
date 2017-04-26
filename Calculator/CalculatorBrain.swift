//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mac on 12/27/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation


func multiply(_ op1: Double, op2: Double) -> Double {
return op1 * op2
}

class CalculatorBrain
{
    
    fileprivate var accumulator=0.0
    
    func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var operations: Dictionary <String, Operation> = [
        "π" : Operation.constant(M_PI),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "=" : Operation.equals,
       // "." : Operation.Dot,
        "C" : Operation.cancel
]
    
    enum Operation{
        
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        //case Dot
        case cancel
        
    }
    
    
    func performOperation(_ symbol: String){
        
        if let operation = operations[symbol]{
            switch operation{
            case .constant (let value): accumulator = value
                
            case .unaryOperation (let function): accumulator = function(accumulator)
                
            case .binaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                
                
                case .equals:
                    if pending != nil {
                accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                        pending = nil
                }
                
           // case .Dot:       if pending != nil {
             //   accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
              //  pending = nil
               // }
                
            case.cancel: accumulator = 0.0
                
            }
        }
    }
    
    fileprivate var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double)->Double
        var firstOperand: Double
    }
    
    
    
    var result: Double {
        get{
            return accumulator
        }
    }
    
}
