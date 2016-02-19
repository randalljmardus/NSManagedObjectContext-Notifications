//
//  Bike+CoreDataProperties.swift
//  NSManagedObjectContext Notifications
//
//  Created by Randall Mardus on 2/19/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Bike {

    @NSManaged var name: String?
    @NSManaged var model: String?
    @NSManaged var brand: String?
    @NSManaged var wheelSize: NSNumber?

}
