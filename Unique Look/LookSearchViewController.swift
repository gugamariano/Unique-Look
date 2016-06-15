//
//  LookSearchTableViewController.swift
//  Unique Look
//
//  Created by antonio silva on 5/1/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth
import Firebase
import FBSDKLoginKit


class LookSearchViewController: UIViewController,UISearchBarDelegate, NSFetchedResultsControllerDelegate , UITableViewDataSource,UINavigationControllerDelegate , UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var look:Look!
    
    lazy var searchbar=UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetch(fetchedResultsController)
        addSearchBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden=false
        fetch(fetchedResultsController)
        tableView.reloadData()
        setupNavBar()
        
        if(fetchedResultsController.fetchedObjects?.count == 0 ){
            self.tabBarController?.selectedIndex = 1
        }
        
    }
    
    func setupNavBar(){
        
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor=UIColor.grayColor()
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.grayColor()]
    }
    
    func addSearchBar(){
        searchbar.placeholder = "Search"
        searchbar.showsCancelButton=false
        searchbar.delegate=self
        navigationController?.navigationBar.barStyle=UIBarStyle.BlackTranslucent
        
        searchbar.frame=CGRect(x: 0, y: 0, width: (view.frame.width - 70) , height: 44)
        
        let leftNavBarButton = UIBarButtonItem(customView: searchbar)
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logOut") , style:.Plain , target:self , action: #selector(LookSearchViewController.logOut))

        
        self.navigationItem.leftBarButtonItem = leftNavBarButton
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
    
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let count = fetchedResultsController.sections?.count ?? 0
        return count
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = fetchedResultsController.sections![section]
        
        
        
        if (sectionInfo.numberOfObjects == 0) {
            
            let label = UILabel()
            label.text = "Your look history is empty!";
            label.textAlignment = .Center
            label.textColor = UIColor.cyanColor()
            label.sizeToFit()
            
            
            self.tableView.backgroundView = label
            
            self.tableView.separatorStyle = .None
            
            return 0
        }else{
            self.tableView.backgroundView = nil
        }
        
        
        
        return sectionInfo.numberOfObjects
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        look = fetchedResultsController.objectAtIndexPath(indexPath) as! Look
        
        self.performSegueWithIdentifier("lookDetailSegue", sender: nil)
        
        
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            let look = fetchedResultsController.objectAtIndexPath(indexPath) as! Look
            look.deleteLook(true)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "lookDetailSegue") {
            let vc=segue.destinationViewController as! LookTagViewController
            vc.look=look
        }
        
    }
    
    
    func getRemoteImage(cell: LookTableViewCell, look: Look) {
        
        if let url=look.thumbUrl {
            
            //print(url)
            
            let task=ImageCache.Static.instance.downloadImage(url) { imageData, error in
                if imageData != nil {
                    
                    //photo.downloadStatus = .Loaded
                    
                    if((imageData) != nil){
                        let image = UIImage(data: imageData!)
                        if((image) != nil){
                            look.saveLocalImage(image!  )
                            
                            cell.photo.hidden=false
                            cell.photo.image=image
                            cell.activityView.stopAnimating()
                        }
                    }
                    
                } else {
                    Utils.showAlert(self, title:"Error", msg:"Download error \(error)")
                    
                }
            }
            
            cell.taskToCancelifCellIsReused = task
        }
    }
    
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        self.tableView!.reloadData()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("lookTableCell",forIndexPath: indexPath) as! LookTableViewCell
        
        let look = fetchedResultsController.objectAtIndexPath(indexPath) as! Look
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat="yyyyMMddhhsss"
        
        let date=NSDate(timeIntervalSince1970: Double(look.creationDate!))
        
        let image = ImageCache.Static.instance.getThumbWithIdentifier(look.id)
        
        if (image != nil){
            cell.activityView.stopAnimating()
            cell.photo.image=image
        }else{
            cell.photo.hidden=true
            cell.activityView.hidden=false
            cell.activityView.startAnimating()
            self.getRemoteImage( cell, look: look)
        }
        
        
        let weekday=look.dayOfWeek!
        let day=NSCalendar.currentCalendar().weekdaySymbols[weekday.integerValue-1]
        
        cell.weekDay.text=day
        
        
        dateFormatter.dateFormat="dd/MM/yyyy HH:mm"
        
        cell.tagList.removeAllTags()
        cell.tagList.cornerRadius=4
        
        
        cell.tagList.addTag(String(dateFormatter.stringFromDate(date))).enableRemoveButton=false
        cell.tagList.addTag(day).enableRemoveButton=false
        
        look.tags!.forEach { tag in
            cell.tagList.addTag(tag.text)
        }
        
        
        
        
        return cell
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton=true
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton=false
        return true
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text=""
        
        fetchedResultsController.fetchRequest.predicate = nil
        fetch(fetchedResultsController)
        // refresh the table view
        self.tableView.reloadData()
        
        searchBar.resignFirstResponder()
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let trimmedSearchString = searchText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // if search string is not blank
        if !trimmedSearchString.isEmpty {
            
            // form the search format
            let predicate = NSPredicate(format: "ANY tags.text BEGINSWITH[cd] %@", trimmedSearchString.lowercaseString)
            
            
            // add the search filter
            fetchedResultsController.fetchRequest.predicate = predicate
        }
        else {
            fetchedResultsController.fetchRequest.predicate = nil
            
        }
        
        fetch(fetchedResultsController)
        
        
        // refresh the table view
        self.tableView.reloadData()
        
        
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest(), managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    func fetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "Look")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchRequest
    }
    
    // update the contents of a fetch results controller
    func fetch(frcToFetch: NSFetchedResultsController) {
        
        do {
            try frcToFetch.performFetch()
        } catch {
            return
        }
    }
    
    
    
}
