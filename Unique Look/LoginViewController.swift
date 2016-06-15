//
//  LoginViewController.swift
//  Unique Look
//
//  Created by antonio silva on 4/11/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import CoreData

// This Class allows the user to log in the App using an existing Facebook profile and listen to Firebase updates
class LoginViewController: UIViewController,UITextFieldDelegate,FBSDKLoginButtonDelegate {
    
    //Mark: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loading: UILabel!
    
    
    //Mark: - Firebase
    let database = FIRDatabase.database().reference()
    
    //Mark: - Core Data
    var localUser:User!
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    func fetchedResultsControllerUser (uid:String) -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "uid == %@", uid)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "uid", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath:nil, cacheName: nil)
        
        return fetchedResultsController
    }
    
    
    func fetchedResultsControllerLooks () -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: "Look")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath:nil, cacheName: nil)
        
        return fetchedResultsController
    }
    
    // Fetch data
    func fetch(frcToFetch: NSFetchedResultsController) {
        
        do {
            try frcToFetch.performFetch()
        } catch {
            return
        }
    }
    
    
    
    //Mark: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        addFBLoginBtn()
    }
    
    func hideLoading(){
        loading.hidden=true
        activityIndicator.stopAnimating()
    }
    func showLoading(){
        
        loading.hidden=false
        activityIndicator.hidden=false
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        Utils.checkConnection(self)
        
        let token=checkFBToken()
        
        if(token != nil){
            showLoading()
            loginAction(token!)
        }else{
            hideLoading()
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Add a FBSDKLoginButton to the bottom of view
    func addFBLoginBtn(){
        
        let fbLogin:FBSDKLoginButton = FBSDKLoginButton()
        
        fbLogin.readPermissions = ["public_profile", "email", "user_friends"]
        fbLogin.delegate = self
        fbLogin.center = CGPoint(x:self.view.frame.width/2 , y:self.view.frame.height - 30)
        
        self.view.addSubview(fbLogin)
        
    }
    
    //Mark: - Firebase Remote Sync
    //This method delete all the Look local database to do a fresh sync with the remote Firebase database
    func deleteLocalLooks() {
        
        let fetchLooks = self.fetchedResultsControllerLooks()
        self.fetch(fetchLooks)
        
        for localLook in fetchLooks.fetchedObjects!{
            let l=localLook as! Look
            l.deleteLook(false)
        }
        
    }
    
    //Check if the local database(Core Data) is synced with Remote Firebase database.
    func syncRemote(user : NSDictionary){
        
        let delegate=UIApplication.sharedApplication().delegate as! AppDelegate
        
        let uid=user[AppConfig.JSONKeys.UID] as! String
        
        let fetchUser = self.fetchedResultsControllerUser(uid)
        self.fetch(fetchUser)
        
        
        //Check if a local User already exists in the local database(Core Data), otherwise create a new one with Facebook data passed in NSDictionary
        if let localUser=fetchUser.fetchedObjects?.first as! User!{
            self.localUser = localUser
        }else{
            self.localUser = User(dictionary: user as! [String : AnyObject], context: self.sharedContext )
            
        }
        
        //set the logged user to AppDelegate to be used later
        delegate.loggedUser=localUser
        
        //Get a reference to the logged User tree on Firebase
        let usersRef = database.child(AppConfig.JSONKeys.USERS).child(uid)
        
        //Listen to any changes on Firebase database
        usersRef.observeEventType(.Value, withBlock: { (snapshot) in
            
            //get the last timestamp that the firebase database was updated
            if let lastUpdate = snapshot.value![AppConfig.JSONKeys.LAST_UPDATE] as! Double!{
                
                //get the last timestamp that the local database(Core Data) was updated
                let last=self.localUser!.lastUpdate ?? 0
                
                if (lastUpdate != last.doubleValue){
                    
                    self.deleteLocalLooks()
                    
                    if let looks=snapshot.value![AppConfig.JSONKeys.LOOKS] as! [String:AnyObject]!{
                        
                        for look in looks{
                            
                            let l=Look(dictionary: look.1 as! [String : AnyObject], context: self.sharedContext)
                            l.user=self.localUser
                            l.id=look.0
                            l.key=look.0
                            
                            if let tags=look.1[AppConfig.JSONKeys.TAGS] as! [String:AnyObject]!{
                                
                                for tag in tags{
                                    
                                    var dic=tag.1 as! [String : AnyObject]
                                    dic[AppConfig.JSONKeys.KEY]=tag.0
                                    
                                    let t=LookTag(dictionary: dic, context: self.sharedContext)
                                    l.addLookTag(t)
                                    
                                }
                                
                                
                            }
                            dispatch_async(dispatch_get_main_queue()){
                                CoreDataStackManager.sharedInstance().saveContext()
                            }
                        }
                    }
                    
                    self.localUser.lastUpdate=Double(lastUpdate)
                    
                    dispatch_async(dispatch_get_main_queue()){
                        CoreDataStackManager.sharedInstance().saveContext()
                    }
                    
                }
                
                
                dispatch_async(dispatch_get_main_queue()){
                    CoreDataStackManager.sharedInstance().saveContext()
                }
            }
            
            
            
        }) { (error) in
            Utils.showAlert(self, title:"Error", msg:"Invalid data")
        }
        
        
        
        
    }
    
    //Mark: - Facebook Login
    // Get a facebook Acess Token and use the Firebase FIRFacebookAuthProvider to signIn the user and update the User tree on Firebase
    func loginAction(accessToken:String) {
        
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            
            if error != nil {
                Utils.showAlert(self, title:"Error Login", msg:"Invalid Login")
            } else {
                
                let date = Double(NSDate().timeIntervalSince1970)
                
                let newUser = [
                    AppConfig.JSONKeys.UID: (user?.uid)!,
                    AppConfig.JSONKeys.PROVIDER: (credential.provider),
                    AppConfig.JSONKeys.DISPLAY_NAME: user!.displayName!,
                    AppConfig.JSONKeys.EMAIL: user!.email!,
                    AppConfig.JSONKeys.LAST_LOGIN:date
                    ] as [String:AnyObject]
                
                //Save the logged user on Firebase User tree
                self.database.child(AppConfig.JSONKeys.USERS)
                    .child(user!.uid).updateChildValues(newUser)
                
                //check if the look local database (Core Data) is in sync with Firebase Database
                self.syncRemote(newUser)
                
                
                dispatch_async(dispatch_get_main_queue()){
                    self.performSegueWithIdentifier("homeSegue", sender: nil)
                }
                
            }
        }
        
    }
    
    
    
    //result from FB login process
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            
            if let token=self.checkFBToken(){
                loginAction(token)
            }else{
                Utils.showAlert(self, title:"Error Login", msg:"Invalid Login")
            }
        }
        else
        {
            NSLog(error.localizedDescription)
        }
    }
    
    
    
    //When user logged out of FB, logout at Udacity
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        
    }
    
    //check the result from FB authentication/authorization and if the token is valid, post and login at Udacity
    func checkFBToken() -> String?{
        if(FBSDKAccessToken.currentAccessToken() != nil){
            
            let token=FBSDKAccessToken.currentAccessToken().tokenString
            
            return token
            
        }else{
            
            return nil
        }
        
    }
    
    
    
}

