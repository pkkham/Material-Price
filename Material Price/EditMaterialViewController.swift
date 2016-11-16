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
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController<Material>!
    
    override func viewDidLoad() {
        convertPrice = price as Double
        
        nameField.text = name
        priceField.text = String(convertPrice)
    }
    
    @IBAction func save(_ sender: Any) {
        if nameField.text == "" && priceField.text == "" {
            alert()
            //dismiss()
        }
        else if nameField.text == "" || priceField.text == "" {
            alert()
            //dismiss()
        }
        else {
            let newPrice = Double(priceField.text!) as NSNumber?
            update(newPrice: newPrice!)
            dismiss()
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
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
    
    func update(newPrice: NSNumber) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Material")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try self.managedObjectContext.fetch(fetchRequest)
            
            if result.count > 0 {
                let material = result[0] as! NSManagedObject
                
                material.setValue(nameField.text, forKey: "name")
                material.setValue(newPrice, forKey: "price")
            }
            
            do {
                try managedObjectContext.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }

}
