//
//  EditMaterialViewController.swift
//  Material Price
//
//  Created by Kristina Khamken on 11/7/16.
//  Copyright © 2016 Kristina Khamken. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditMaterialViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    var name: String!
    var price: NSNumber!
    var convertPrice: Double!
    
    override func viewDidLoad() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        convertPrice = price as Double
        
        nameField.text = name
        priceField.text = formatter.string(from: convertPrice as NSNumber)
    }
    
}
