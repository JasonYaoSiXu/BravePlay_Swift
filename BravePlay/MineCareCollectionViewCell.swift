//
//  MineCareCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineCareCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var careTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        careTableView.backgroundColor = UIColor.clearColor()
        // Initialization code
    }

}
