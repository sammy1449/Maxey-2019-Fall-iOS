//
//  ViewController.swift
//  Homework2
//
//  Created by Samantha Maxey on 9/9/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Calculator: UILabel!
    
    @IBOutlet weak var var1: UITextField!
    
    @IBOutlet weak var var2: UITextField!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Calculator.text = " Calculator"
        
    }

    class UIStackView : UIView{
        
    }
    
    @IBAction func calculateMutiply(_ sender: Any) {
        
        let number1 = Double(var1.text!) ?? 0
        let number2 = Double(var2.text!) ?? 0
        
        
        let answer = number1 * number2
        
        let convert = String(answer)
        
        outputLabel.text = convert
    }
    
    
    @IBAction func calculateDivide(_ sender: Any) {
        
        let number1 = Double(var1.text!) ?? 0
        let number2 = Double(var2.text!) ?? 0
        
        if(number2 == 0){
            outputLabel.text = "Error"
        }else{
            let answer = number1 / number2
            
            let convert = String(answer)
            
            outputLabel.text = convert
        }
        
    }
    
    @IBAction func calculateAdd(_ sender: Any) {
        
        let number1 = Double(var1.text!) ?? 0
        let number2 = Double(var2.text!) ?? 0
        
        
        let answer = number1 + number2
        
        let convert = String(answer)
        
        outputLabel.text = convert
    }
    
    @IBAction func calculateSubtract(_ sender: Any) {
        
        let number1 = Double(var1.text!) ?? 0
        let number2 = Double(var2.text!) ?? 0
        
        
        let answer = number1 - number2
        
        let convert = String(answer)
        
        outputLabel.text = convert
    }
    
}


