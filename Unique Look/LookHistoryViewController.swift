    //
    //  LookHistoryViewController.swift
    //  yniquedress
    //
    //  Created by antonio silva on 4/22/16.
    //  Copyright © 2016 antonio silva. All rights reserved.
    //

    import Foundation
    import AVFoundation
    import UIKit
    import MobileCoreServices
    import CoreData

    class LookHistoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate ,UINavigationControllerDelegate, UISearchBarDelegate {
        
        var look: Look!
        var imagePicker: UIImagePickerController!
        
        private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        var selectedIndexes = [NSIndexPath]()
        // Keep the changes. We will keep track of insertions, deletions, and updates.
        var insertedIndexPaths: [NSIndexPath]!
        var deletedIndexPaths: [NSIndexPath]!
        var updatedIndexPaths: [NSIndexPath]!

        @IBOutlet weak var collectionView: UICollectionView!
        
        lazy var searchbar=UISearchBar()
        
        override func viewDidLoad() {
        
            super.viewDidLoad()
            
        }
        
        override func viewWillAppear(animated: Bool) {
            
            super.viewWillAppear(true)
            self.tabBarController?.tabBar.hidden=false

            self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
            self.navigationController?.navigationBar.tintColor=UIColor.grayColor()
            self.navigationController?.navigationBar.titleTextAttributes =
                [NSForegroundColorAttributeName: UIColor.grayColor()]
            
            navigationItem.title="Look history - Weekday"
            fetch(fetchedResultsController)
            collectionView.reloadData()
        }
        
        // update the contents of a fetch results controller
        func fetch(frcToFetch: NSFetchedResultsController) {
            
            do {
                try frcToFetch.performFetch()
            } catch {
                return
            }
        }

        
        func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
            searchBar.showsCancelButton=true
            return true
        }
        
        func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
            searchBar.showsCancelButton=false
            return true
        }
        
        override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        
            searchbar.sizeToFit()
        }
        
        
        
        var sharedContext: NSManagedObjectContext {
            return CoreDataStackManager.sharedInstance().managedObjectContext
        }
        
        lazy var fetchedResultsController: NSFetchedResultsController = {
            let fetchRequest = NSFetchRequest(entityName: "Look")
            //fetchRequest.predicate = NSPredicate(format: "pin == %@", self.pin)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dayOfWeek", ascending: true), NSSortDescriptor(key: "creationDate", ascending: false)]
            
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: "dayOfWeek", cacheName: nil)
            
            fetchedResultsController.delegate = self
            
            return fetchedResultsController
        }()
        
        
        
        
        
        //MARK: - CollectionView
        func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            let count = fetchedResultsController.sections?.count ?? 0
            
            return count
        }
        
        
        
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let sectionInfo = fetchedResultsController.sections![section]
            
            return sectionInfo.numberOfObjects
        }
        

        
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("lookCell", forIndexPath: indexPath) as! LookCell
            
            let look = fetchedResultsController.objectAtIndexPath(indexPath) as! Look
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat="yyyyMMddhhsss"
            
            
            let id=look.creationDate
            
            let date=NSDate(timeIntervalSince1970: Double(id!))
            
            let image = ImageCache.Static.instance.imageWithIdentifier(String(look.creationDate))
            
            if (image != nil){
                cell.photo.image=image
            }
            dateFormatter.dateFormat="dd/MM/yyyy"
            cell.date.text=String(dateFormatter.stringFromDate(date))
            
            return cell
            
        }
        
        func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
            
            look = fetchedResultsController.objectAtIndexPath(indexPath) as! Look
            
            self.performSegueWithIdentifier("lookDetailSegue", sender: nil)

            
            
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
            if(segue.identifier == "lookDetailSegue") {
                let vc=segue.destinationViewController as! LookTagViewController
                vc.look=look
                
            }
            
        }
        
        
        func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            
            if kind == UICollectionElementKindSectionHeader {
                
                let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader , withReuseIdentifier: "lookHeader", forIndexPath: indexPath) as! LookCollectionHeaderView
                
                let look=fetchedResultsController.sections![indexPath.section].objects![0] as! Look
                
                let weekday=look.dayOfWeek!
                
                let day=NSCalendar.currentCalendar().weekdaySymbols[weekday.integerValue-1]
                
                header.title.text = "What you usually wear on \(day)"
                
                return header
                
            }else{
                return UICollectionReusableView()
                
            }
        }
        
        
        // Whenever changes are made to Core Data the following three methods are invoked. This first method is used to create
        // three fresh arrays to record the index paths that will be changed.
        func controllerWillChangeContent(controller: NSFetchedResultsController) {
            // We are about to handle some new changes. Start out with empty arrays for each change type
            insertedIndexPaths = [NSIndexPath]()
            deletedIndexPaths = [NSIndexPath]()
            updatedIndexPaths = [NSIndexPath]()
            
        }
        
        // The second method may be called multiple times, once for each Color object that is added, deleted, or changed.
        // We store the incex paths into the three arrays.
        func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
            
            switch type{
                
            case .Insert:
                
                insertedIndexPaths.append(newIndexPath!)
                break
            case .Delete:
                
                deletedIndexPaths.append(indexPath!)
                break
            case .Update:
                
                updatedIndexPaths.append(indexPath!)
                break
            case .Move:
                
                break
                       }
        }
        
        
        func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
            
                if type == NSFetchedResultsChangeType.Insert {
                    self.collectionView!.insertSections(NSIndexSet(index: sectionIndex))
                }
            
        }
        
        // This method is invoked after all of the changed in the current batch have been collected
        // into the three index path arrays (insert, delete, and upate). We now need to loop through the
        // arrays and perform the changes.
        
        func controllerDidChangeContent(controller: NSFetchedResultsController) {
            
            self.collectionView!.performBatchUpdates({() -> Void in
                
                for indexPath in self.insertedIndexPaths {
                    
                    self.collectionView!.insertItemsAtIndexPaths([indexPath])
                }
                
                for indexPath in self.deletedIndexPaths {
                    self.collectionView!.deleteItemsAtIndexPaths([indexPath])
                }
                
                for indexPath in self.updatedIndexPaths {
                    self.collectionView!.reloadItemsAtIndexPaths([indexPath])
                }
                
                }, completion: nil)
            
        }
        
        
        func searchBarSearchButtonClicked(searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        func searchBarCancelButtonClicked(searchBar: UISearchBar) {
            searchBar.text=""
            searchBar.resignFirstResponder()
        }
        
        
    }

    //extension LookHistoryViewController : UICollectionViewDelegateFlowLayout{
    //    
    //    func collectionView(collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    //        
    //        return sectionInsets
    //        
    //    }
    //    
    //    func collectionView(collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    //        
    //        return CGSize(width: 80 , height: 80)
    //    }
    //    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    //        return 1
    //    }
    //    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    //        return 1
    //    }
    //    
    //}
    extension NSDate {
        func dayOfWeek() -> Int? {
            guard
                let cal: NSCalendar = NSCalendar.currentCalendar(),
                let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) else { return nil }
            return comp.weekday
        }
    }


