//
//  LookDetailViewController.swift
//  Unique Look
//
//  Created by antonio silva on 4/24/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import TagListView

class LookTagViewController: UIViewController,TagListViewDelegate,UITextFieldDelegate {

    var look:Look!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tagText: UITextField!
    
    
    @IBAction func addTag(sender: AnyObject) {
        
        let t = tagText.text!
        look.addTag(t)
        
        tagListView.addTag(t)

        tagText.text=""
        tagText.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagListView.delegate=self
        tagText.delegate=self

    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        Utils.checkConnection(self)
        setup()
        
        
    }
    

    ///return after done
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addTag(self)
        return true
    }
    
    
    ///Get the keyboard height to use when need to scroll the screen.
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    
    func setup(){
    
        self.tabBarController?.tabBar.hidden=true
        
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor=UIColor.grayColor()
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.grayColor()]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat="yyyyMMddhhsss"

        let date=NSDate(timeIntervalSince1970:Double(look.creationDate!))
        
        let image = ImageCache.Static.instance.imageWithIdentifier(look.id)
        
        if(image == nil){
            self.activityIndicator.hidden=false
            self.activityIndicator.startAnimating()
            
            ImageCache.Static.instance.downloadAndSaveImage(look.id, url: look.url!){image,thumb,error in
                
                self.imageView.image=image
                self.activityIndicator.stopAnimating()
            }
        }else{
            self.activityIndicator.stopAnimating()
            imageView.image=image
        }
        
        tagListView.enableRemoveButton=true
        //tagListView.textFont = tagText.font!.fontWithSize(16)
        
            
        tagListView.alignment = .Left // possible values are .Left, .Center, and .Right
        
        tagListView.tagBackgroundColor=UIColor.grayColor()
        tagListView.cornerRadius=4
        tagListView.removeButtonIconSize=14
        
        dateFormatter.dateFormat="dd/MM/yyyy HH:mm"
        
        let weekday=look.dayOfWeek!
        let day=NSCalendar.currentCalendar().weekdaySymbols[weekday.integerValue-1]
        
        tagListView.addTag(String(dateFormatter.stringFromDate(date))).enableRemoveButton=false
        tagListView.addTag(day).enableRemoveButton=false
        
        look.tags!.forEach { tag in
            tagListView.addTag(tag.text)
        }
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    // MARK: TagListViewDelegate
    func tagPressed(title: String, tagView: TagView, sender: TagListView) {
        tagView.selected = !tagView.selected
    }
    
    func tagRemoveButtonPressed(title: String, tagView: TagView, sender: TagListView) {

        look.deleteTag(title)
        sender.removeTagView(tagView)
    }
    

}
