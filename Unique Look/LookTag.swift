//
//  LookTag.swift
//  Unique Look
//
//  Created by antonio silva on 4/30/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import Foundation
import CoreData


class LookTag: NSManagedObject {

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    
    init(dictionary: NSDictionary, context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("LookTag", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)

        text=dictionary["text"] as! String!
        creationDate=dictionary["creationDate"] as! Double!
        
        if let k = dictionary["key"] as? String {
            key=k
        }
        
    }
}
