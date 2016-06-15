//
//  LookTabBar.swift
//  Unique Look
//
//  Created by antonio silva on 5/7/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import UIKit

class LookTabBar: UITabBar {

    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 44
        return sizeThatFits
    }
    
    
}
