//
//  Material+CoreDataProperties.swift
//  Material Price
//
//  Created by Kristina Khamken on 7/25/16.
//  Copyright © 2016 Kristina Khamken. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Material {

    @NSManaged var name: String?
    @NSManaged var price: NSNumber?
    @NSManaged var desc: String?

}
