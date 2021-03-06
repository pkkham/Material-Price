//
//  MaterialTableViewController.swift
//  Material Price
//
//  Created by Kristina Khamken on 7/25/16.
//  Copyright © 2016 Kristina Khamken. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MaterialTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController<Material>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        }
        catch _ {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "calculate") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let calculateController:CalculateViewController = segue.destination as! CalculateViewController
            let material:Material = fetchedResultController.object(at: indexPath!)
            calculateController.mat_name = material.name
            calculateController.mat_price = material.price
        }
        
        if (segue.identifier == "edit") {
            //let cell = sender as! UITableViewCell
            //let indexPath = tableView.indexPath(for: cell)
            let editController:EditMaterialViewController = segue.destination as! EditMaterialViewController
            let material:Material = fetchedResultController.object(at: sender! as! IndexPath)
            editController.name = material.name
            editController.price = material.price
        }
    }
    
    func getFetchedResultController() -> NSFetchedResultsController<Material> {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func taskFetchRequest() -> NSFetchRequest<Material> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        
        if #available(iOS 10.0, OSX 10.12, *) {
            fetchRequest = Material.fetchRequest()
        }
        else {
            fetchRequest = NSFetchRequest(entityName: "Material")
        }
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest as! NSFetchRequest<Material>
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let material = fetchedResultController.object(at: indexPath)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let matPrice = material.price!
        
        cell.textLabel?.text = material.name
        cell.detailTextLabel?.text = formatter.string(from: matPrice)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?  {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let managedObject:NSManagedObject = self.fetchedResultController.object(at: indexPath) as NSManagedObject
            self.managedObjectContext.delete(managedObject)
            do {
                try self.managedObjectContext.save()
            } catch _ {
            }
            
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "edit", sender: indexPath)
        }
        
        return [delete, edit]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
