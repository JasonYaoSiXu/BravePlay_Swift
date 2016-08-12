//
//  MoreDetailTitleTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MoreDetailTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        bgView.backgroundColor = UIColor ( red: 0.1255, green: 0.1765, blue: 0.1922, alpha: 1.0 )
        titleView.backgroundColor = UIColor ( red: 0.749, green: 0.5098, blue: 0.0667, alpha: 1.0 )
        titleLabel.textColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
