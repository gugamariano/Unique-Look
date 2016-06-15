//
//  LookTableViewCell.swift
//  Unique Look
//
//  Created by antonio silva on 5/1/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import UIKit
import TagListView

class LookTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var creationDate: UILabel!
    
    @IBOutlet weak var weekDay: UILabel!
    
    @IBOutlet weak var tagList: TagListView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    
    var taskToCancelifCellIsReused: NSURLSessionTask? {
        
        didSet {
            if let taskToCancel = oldValue {
                taskToCancel.cancel()
            }
        }
    }
    
}
