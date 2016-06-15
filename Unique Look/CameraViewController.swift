//
//  CameraViewController.swift
//  Unique Look
//
//  Created by antonio silva on 4/11/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FBSDKLoginKit

// This Class Handles the interaction with Camera and PhotoAlbum controller allowing the user to create a new look to tag and search for later. 
// Both Core data and Firebase were used just to be compliant with Udacity grading rubric (Must use Core Data)
class CameraViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    var look: Look!
    
    //Mark: - Firebase database
    let firebase=FIRDatabase.database().reference()
    let storage = FIRStorage.storage()
    
    //Mark: UI
    // Shows the libray to choose a picture
    @IBAction func choosePicture(sender: AnyObject) {
        showLibray()
    }
    
    // Shows the Camera to take a picture
    @IBAction func takePicture(sender: AnyObject) {
        showCamera()
    }
    
    //Mark: View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //Make sure the tabBar is not hidden
        self.tabBarController?.tabBar.hidden=false
        
        //change the look and feel of navigationbar
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.grayColor()]
        
        navigationItem.title="Add a new look"
        

        let logoutButton = UIBarButtonItem(image: UIImage(named: "logOut") , style:.Plain , target:self , action: #selector(CameraViewController.logOut))
        self.navigationItem.rightBarButtonItem=logoutButton
        
    }
    
    func logOut(){
        
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        } catch let signOutError as NSError {
            Utils.showAlert(self, title:"Error logout", msg:signOutError.description)
        }
        
        
        let vc=self.storyboard?.instantiateViewControllerWithIdentifier("loginViewController")
        presentViewController(vc!, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: - Core Data
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    //Check if the camera is available and show the UIImagePickerController with camera type
    func showCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            
            let imagePickController = UIImagePickerController()
            
            imagePickController.delegate=self
            imagePickController.sourceType=UIImagePickerControllerSourceType.Camera
            
            presentViewController(imagePickController, animated:true, completion: nil)
            
            
        }
    }
    
    //Mark: - Camera and Photo Library
    //Check if the Album is available and show the UIImagePickerController with PhotoLibrary type
    func showLibray() {
        if (UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)) {
            
            let imagePickController = UIImagePickerController()
            
            imagePickController.delegate=self
            imagePickController.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
            
            presentViewController(imagePickController, animated:true, completion: nil)
            
            
        }
    }
    
    //Handle the image that was taken with camera or choosen in PhotoLibrary by the user
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        saveLook(image)
        
    }
    
    //Create a new Look Entity(Core Data) and update the Firebase remote database.
    func saveLook(image:UIImage){
        
        let delegate=UIApplication.sharedApplication().delegate as! AppDelegate
        
        let creationDate = NSDate()
        let dayOfWeek = NSDate().dayOfWeek()
        let id=Double(creationDate.timeIntervalSince1970)
        
        let dic = [AppConfig.JSONKeys.ID : id, AppConfig.JSONKeys.LAST_UPDATE : id,AppConfig.JSONKeys.CREATION_DATE : id , AppConfig.JSONKeys.DAY_OF_WEEK : dayOfWeek!] as NSMutableDictionary
        
        
        self.look=Look(dictionary: dic, context: self.sharedContext)
        self.look.user=delegate.loggedUser
        
        
        let usersRef = self.firebase.child(AppConfig.JSONKeys.USERS).child(delegate.loggedUser!.uid!)
        let lookRef=usersRef.child(AppConfig.JSONKeys.LOOKS).childByAutoId();
        
        usersRef.updateChildValues([AppConfig.JSONKeys.LAST_UPDATE:Double(id)])
        lookRef.setValue(dic)
        
        self.look.key=lookRef.key
        self.look.id=lookRef.key
        self.look.lastUpdate=id
        self.look.user?.lastUpdate=id
        
        look.saveImage(image)
        
        dispatch_async(dispatch_get_main_queue()){
            CoreDataStackManager.sharedInstance().saveContext()
            self.performSegueWithIdentifier(AppConfig.Constants.SEGUE_LOOK_DETAILS_TAG, sender: nil)
        }
        
        
    }
    
    
    //Mark: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == AppConfig.Constants.SEGUE_LOOK_DETAILS_TAG) {
            let vc=segue.destinationViewController as! LookTagViewController
            vc.look=look
        }
        
    }
}