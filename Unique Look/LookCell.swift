//
//  PhotoCell.swift
//  Unique Look
//
//  Created by antonio silva on 2/11/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import Foundation
import UIKit

class LookCell : UICollectionViewCell{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    
    // From iOS Persistance course
    // The property uses a property observer. Any time its
    // value is set it canceles the previous NSURLSessionTask
    var taskToCancelifCellIsReused: NSURLSessionTask? {
        
        didSet {
            if let taskToCancel = oldValue {
                taskToCancel.cancel()
            }
        }
    }
    
}