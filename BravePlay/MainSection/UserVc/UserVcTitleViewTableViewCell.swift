//
//  UserVcTitleViewTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/15.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class UserVcTitleViewTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        bgView.backgroundColor = UIColor.clearColor()
        titleView.backgroundColor = UIColor ( red: 0.9922, green: 0.6353, blue: 0.0392, alpha: 1.0 )
        titleLabel.textColor = UIColor ( red: 0.9922, green: 0.6353, blue: 0.0392, alpha: 1.0 )
        titleLabel.text = "相关推荐"
        titleLabel.sizeToFit()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
