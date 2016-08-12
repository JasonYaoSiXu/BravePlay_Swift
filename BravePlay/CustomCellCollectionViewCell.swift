//
//  CustomCellCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/7/29.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class CustomCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customHeadImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var action: ((Void) -> (String,String,String))?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        customHeadImage.clipsToBounds = true
        customHeadImage.contentMode = .ScaleAspectFill
        // Initialization code
        
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.hidden = true
    }
    
}
