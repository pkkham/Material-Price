//
//  CalculateViewController.swift
//  Material Price
//
//  Created by Kristina Khamken on 8/31/16.
//  Copyright © 2016 Kristina Khamken. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CalculateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var field_1: UITextField!
    @IBOutlet weak var materialName: UILabel!
    @IBOutlet weak var materialPrice: UILabel!
    
    var mat_name : String!
    var mat_price : NSNumber!
    var convertPrice : Double!
    var amount : Double!

    override func viewDidLoad() {
        self.field_1.delegate = self
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        convertPrice = mat_price as Double
        
        materialName.text = mat_name
        materialPrice.text = formatter.string(from: convertPrice as NSNumber)
        
        totalAmount.text = "$0"
        
    }
    
    @IBAction func clearAmount(_ sender: AnyObject) {
        amount = 0
        totalAmount.text = "$0"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        calculate()
    }
    
    func calculate() {
        if (field_1.text == "") {
            amount = mat_price as Double
        }
        else {
            let input:Double = Double(field_1.text!)!
            amount = convertPrice * input
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        totalAmount.text = formatter.string(from: amount as NSNumber)
    }
}
