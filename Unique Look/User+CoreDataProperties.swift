//
//  User+CoreDataProperties.swift
//  Unique Look
//
//  Created by antonio silva on 5/24/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var uid: String?
    @NSManaged var displayName: String?
    @NSManaged var lastLogin: NSNumber?
    @NSManaged var lastUpdate: NSNumber?
    @NSManaged var creationDate: NSNumber?
    @NSManaged var provider: String?
    
    @NSManaged var email: String?
    @NSManaged var looks: NSSet?

    

}
