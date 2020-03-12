//
//  ViewController.swift
//  norm_calc
//
//  Created by Pavel on 05/03/2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTyping = false
    var firstoperand: Double = 0
    var secondoperand: Double = 0
    var operationSign: String = ""
    var dotIsPlaced = false
    var CurrentInput: Double {
        get{
            return Double(displayResultLabel.text!)!
        }
        set{
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            }else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard displayResultLabel.text?.count ?? 0 < 20 else { return }
        
        let number = sender.currentTitle!
        
        if stillTyping {
           displayResultLabel.text = displayResultLabel.text! + number
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstoperand = CurrentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondoperand = CurrentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
            case "+":
            operateWithTwoOperands{$0 + $1}
            case "-":
            operateWithTwoOperands{$0 - $1}
            case "×":
            operateWithTwoOperands{$0 * $1}
            case "÷":
            operateWithTwoOperands{$0 / $1}
        default:
            break;
        }
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double){
        CurrentInput = operation(firstoperand, secondoperand)
        stillTyping = false
    }
    
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced{
            displayResultLabel.text = displayResultLabel.text! + "."
           dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced{
            displayResultLabel.text = "0."
        }
    }
    
    @IBAction func squareButtonBressed(_ sender: UIButton) {
        CurrentInput = sqrt(CurrentInput)
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstoperand == 0 {
            CurrentInput = CurrentInput / 100
        } else {
            secondoperand = firstoperand * CurrentInput/100
        }
        stillTyping = false
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        CurrentInput = -CurrentInput
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstoperand = 0;
        secondoperand = 0;
        CurrentInput = 0;
        displayResultLabel.text = "0"
        stillTyping = false
        operationSign = ""
        dotIsPlaced = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override  var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}

