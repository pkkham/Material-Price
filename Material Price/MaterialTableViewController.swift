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
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
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
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Material")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let material = fetchedResultController.objectAtIndexPath(indexPath) as! Material
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        let matPrice = material.price!
        
        cell.textLabel?.text = material.name
        cell.detailTextLabel?.text = formatter.stringFromNumber(matPrice)
        return cell
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
}
