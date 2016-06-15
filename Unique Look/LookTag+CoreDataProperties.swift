//
//  LookTag+CoreDataProperties.swift
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

extension LookTag {

    @NSManaged var text: String?
    @NSManaged var creationDate: NSNumber?
    @NSManaged var key: String?
    @NSManaged var look: Look?


}
