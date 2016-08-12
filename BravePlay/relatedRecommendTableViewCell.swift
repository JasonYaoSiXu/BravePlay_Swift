//
//  relatedRecommendTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class relatedRecommendTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var careButton: UIButton!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        bgView.backgroundColor = UIColor ( red: 0.1451, green: 0.2039, blue: 0.2196, alpha: 1.0 )
        headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2
        headImageView.layer.masksToBounds = true
        headImageView.clipsToBounds = true
        headImageView.contentMode = .ScaleAspectFill
        
        careButton.setTitle("关注", forState: .Normal)
        careButton.setTitleColor(UIColor ( red: 0.749, green: 0.5098, blue: 0.0667, alpha: 1.0 ), forState: .Normal)
        careButton.layer.cornerRadius = careButton.bounds.size.height / 2
        careButton.layer.masksToBounds = true
        careButton.layer.borderWidth = 1
        careButton.layer.borderColor = UIColor ( red: 0.749, green: 0.5098, blue: 0.0667, alpha: 1.0 ).CGColor
        
        nickLabel.textColor = UIColor.whiteColor()
        personLabel.textColor = UIColor ( red: 0.3373, green: 0.3882, blue: 0.4039, alpha: 1.0 )
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapCareButton(sender: AnyObject) {
        
    }
    
}
