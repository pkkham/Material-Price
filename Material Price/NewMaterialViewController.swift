//
//  NewMaterialViewController.swift
//  Material Price
//
//  Created by Kristina Khamken on 7/25/16.
//  Copyright © 2016 Kristina Khamken. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewMaterialViewController: UIViewController {
    

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    @IBAction func save(_ sender: AnyObject) {
        if nameField.text == "" && priceField.text == "" {
            alert()
            //dismiss()
        }
        else if nameField.text == "" || priceField.text == "" {
            alert()
            //dismiss()
        }
        else {
            createNew()
            dismiss()
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        dismiss()
    }
    
    func dismiss() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func alert() {
        let alertView = UIAlertController(title: "Invalid Material",
                                          message: "Please fill in the empty sections",
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
        
    
    func createNew() {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Material", in: managedObjectContext)
        let material = Material(entity: entityDescription!, insertInto: managedObjectContext)
        material.name = nameField.text
        material.price = Double(priceField.text!) as NSNumber?
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
}
