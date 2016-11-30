//
//  UserVcRecommendCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/15.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class UserVcRecommendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recommendImageView: UIImageView!
    @IBOutlet weak var recommendLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        
        recommendImageView.layer.cornerRadius = recommendImageView.bounds.size.height / 2
        recommendImageView.layer.masksToBounds = true
        recommendImageView.clipsToBounds = true
        recommendImageView.contentMode = .ScaleAspectFill
        
        recommendLabel.textColor = UIColor.whiteColor()
        recommendLabel.text = "Red Bull"
        
        // Initialization code
    }

}
