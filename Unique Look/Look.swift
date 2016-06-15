//
//  Look.swift
//  Unique Look
//
//  Created by antonio silva on 4/17/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import Foundation
import CoreData
import Firebase

class Look: NSManagedObject {
    
    let database=FIRDatabase.database().reference()
    let storage = FIRStorage.storage().referenceForURL(AppConfig.Constants.FIREBASE_BUCKET)
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    
    init(dictionary: NSDictionary, context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("Look", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        id = dictionary[AppConfig.JSONKeys.ID] as? String
        creationDate = dictionary[AppConfig.JSONKeys.CREATION_DATE] as? Double
        lastUpdate = dictionary[AppConfig.JSONKeys.LAST_UPDATE] as? Double
        dayOfWeek = dictionary[AppConfig.JSONKeys.DAY_OF_WEEK] as? NSNumber
        thumbUrl=dictionary[AppConfig.JSONKeys.THUMB_URL] as? String
        url=dictionary[AppConfig.JSONKeys.IMAGE_URL] as? String
        
        
    }
    func addLookTag(tag:LookTag){
        
        var set=tags?.allObjects
        set?.append(tag)
        tags!.setByAddingObject(set!)
        tag.look=self
        
        
        dispatch_async(dispatch_get_main_queue()){
            CoreDataStackManager.sharedInstance().saveContext()
        }
    }
    
    func addTag(t:String){
        if(tags==nil){
            tags=NSSet()
        }
        var set=tags!.allObjects
        
        let id=Double(NSDate().timeIntervalSince1970)
        
        let dic = ["text" : t, AppConfig.JSONKeys.CREATION_DATE : id]
        
        let tag=LookTag(dictionary: dic as NSDictionary , context: sharedContext)
        
        set.append(tag)
        tags!.setByAddingObject(set)
        
        tag.look=self
        
        self.user!.lastUpdate=id
        self.lastUpdate=id
        
        let usersRef = database.child(AppConfig.JSONKeys.USERS).child(user!.uid!)
        usersRef.updateChildValues([AppConfig.JSONKeys.LAST_UPDATE: id])
        
        let tagFb=usersRef.child(AppConfig.JSONKeys.LOOKS).child(key!).child(AppConfig.JSONKeys.TAGS).childByAutoId()
        
        tag.key=tagFb.key
        
        tagFb.setValue(dic)
        
        dispatch_async(dispatch_get_main_queue()){
            CoreDataStackManager.sharedInstance().saveContext()
        }
        
    }
    
    func deleteTag(tag:String){
        
        var lookTag: LookTag!
        
        for t in tags!{
            
            if(t.text == tag){
                lookTag=t as! LookTag
                break
            }
        }
        
        if(lookTag != nil){
            let delegate=UIApplication.sharedApplication().delegate as! AppDelegate
            
            let id=Double(NSDate().timeIntervalSince1970)
            self.user!.lastUpdate=id
            let usersRef = database.child(AppConfig.JSONKeys.USERS).child(delegate.loggedUser!.uid!)
            usersRef.updateChildValues([AppConfig.JSONKeys.LAST_UPDATE: id])
            
            usersRef.child(AppConfig.JSONKeys.LOOKS).child((lookTag.look?.key)!).child(AppConfig.JSONKeys.TAGS).child(lookTag.key!).removeValue()
            
        }
        
        dispatch_async(dispatch_get_main_queue()){
            CoreDataStackManager.sharedInstance().managedObjectContext.deleteObject(lookTag)
            CoreDataStackManager.sharedInstance().saveContext()
        }
    }
    
    func deleteLookRemote(lastUpdate:Double){
        let usersRef = database.child(AppConfig.JSONKeys.USERS).child(user!.uid!)
        usersRef.updateChildValues([AppConfig.JSONKeys.LAST_UPDATE:lastUpdate])
        let lookRef=usersRef.child(AppConfig.JSONKeys.LOOKS).child(self.key!)
        lookRef.removeValue()
        
    }
    
    func deleteLook(remote:Bool){
        
        
        let id=Double(NSDate().timeIntervalSince1970)
        self.user?.lastUpdate=id
        
        managedObjectContext!.deleteObject(self)
        ImageCache.Static.instance.removeImage(self.id)
        
        if(remote){
            deleteLookRemote(id)
        }
        
        try! managedObjectContext!.save()
        
        
    }
    
    
    func saveLocalImage(image: UIImage){
        //store local image and thumbnail
        ImageCache.Static.instance.storeThumbImage(image, width: 300,height: 300, path: id!)
        ImageCache.Static.instance.storeImage(image, withIdentifier: id!)
        
    }
    func saveImage(image: UIImage) {
        
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let usersRef = self.database.child(AppConfig.JSONKeys.USERS).child(user!.uid!)
        let lookRef=usersRef.child(AppConfig.JSONKeys.LOOKS).child(id!)
        
        //store local image and thumbnail
        let thumb=ImageCache.Static.instance.storeThumbImage(image, width: 300,height: 300, path: String(id!))
        let img=ImageCache.Static.instance.storeImage(image, withIdentifier: String(id!))
        
        let imgRef=storage.child(AppConfig.JSONKeys.IMAGES).child(id!)
        let thumbsRef=storage.child(AppConfig.JSONKeys.THUMBS).child(id!)
        
        
        _ = imgRef.putData(img, metadata: metadata) { metadata, error in
            if (error != nil) {
                print(error)
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata?.downloadURL()?.absoluteString
                self.url=downloadURL
                
                let dic = [AppConfig.JSONKeys.IMAGE_URL :downloadURL!] as [String : String]
                lookRef.updateChildValues(dic)
                
            }
        }
        
        
        _ = thumbsRef.putData(thumb, metadata: metadata) { metadata, error in
            if (error != nil) {
                print(error)
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata?.downloadURL()?.absoluteString
                self.thumbUrl=downloadURL
                print(downloadURL)
                let dic = [AppConfig.JSONKeys.THUMB_URL :downloadURL!] as [NSObject : AnyObject]
                lookRef.updateChildValues(dic)
                
            }
        }
        
        
        dispatch_async(dispatch_get_main_queue()){
            CoreDataStackManager.sharedInstance().saveContext()
        }
        
    }
    
    
    
}
