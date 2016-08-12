//
//  HeadViewAcFirstSectionTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/3.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class HeadViewAcFirstSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var jumpButton: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        bgView.backgroundColor = UIColor ( red: 0.1608, green: 0.2314, blue: 0.2392, alpha: 1.0 )
        jumpButton.hidden = true
        titleLabel.textColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapJumpButton(sender: UIButton) {
        
    }
    
}
