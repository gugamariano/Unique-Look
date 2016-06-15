//
//  User.swift
//  Unique Look  
//
//  Created by antonio silva on 5/24/16.
//
//

import Foundation
import CoreData


class User: NSManagedObject {

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("User", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        
        uid = dictionary["uid"] as? String
        email = dictionary["email"] as? String
        displayName = dictionary["displayName"] as? String
        provider = dictionary["provider"] as? String
        lastLogin = dictionary["lastLogin"] as? Double
        lastUpdate = dictionary["lastUpdate"] as? Double
        creationDate = dictionary["creationDate"] as? Double
    }

}
