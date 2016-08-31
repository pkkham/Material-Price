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
    @IBOutlet weak var descField: UITextView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBAction func save(sender: AnyObject) {
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
    
    @IBAction func cancel(sender: AnyObject) {
        dismiss()
    }
    
    func dismiss() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func alert() {
        let alertView = UIAlertController(title: "Invalid Material",
                                          message: "Please fill in the empty sections",
                                          preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
        
    
    func createNew() {
        let entityDescription = NSEntityDescription.entityForName("Material", inManagedObjectContext: managedObjectContext)
        let material = Material(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        material.name = nameField.text
        material.price = Double(priceField.text!)
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
}
