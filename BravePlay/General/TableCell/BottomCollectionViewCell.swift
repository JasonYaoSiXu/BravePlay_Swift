//
//  BottomCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/2.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var avtarImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var careButton: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    var hasCor: Bool = false {
        didSet {
            if hasCor {
                avtarImg.layer.cornerRadius = avtarImg.bounds.width / 2
                avtarImg.layer.masksToBounds = true
                bgView.backgroundColor = UIColor.blackColor()
                bgView.alpha = 0.8
            } else {
                avtarImg.layer.cornerRadius = 0
                bgView.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        
        headImg.clipsToBounds = true
        headImg.contentMode = .ScaleAspectFill
        
        titleLabel.textAlignment = .Center
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.whiteColor()
        
        careButton.backgroundColor = UIColor.clearColor()
        careButton.setTitle("关注", forState: .Normal)
        careButton.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
        careButton.layer.cornerRadius = careButton.bounds.height / 2
        careButton.layer.borderColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ).CGColor
        careButton.layer.borderWidth = 1
    }

    
    @IBAction func tapCareButton(sender: UIButton) {
        
    }
    
}
