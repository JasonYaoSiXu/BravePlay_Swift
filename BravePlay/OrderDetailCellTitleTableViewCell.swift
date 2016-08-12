//
//  OrderDetailCellTitleTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class OrderDetailCellTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remarksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        bgView.backgroundColor = UIColor ( red: 0.1176, green: 0.1686, blue: 0.1922, alpha: 1.0 )
        titleView.backgroundColor = UIColor ( red: 0.949, green: 0.549, blue: 0.051, alpha: 1.0 )
        titleLabel.textColor = UIColor.whiteColor()
        remarksLabel.textColor = UIColor.whiteColor()
        titleLabel.textColor = UIColor ( red: 0.4039, green: 0.2784, blue: 0.1255, alpha: 1.0 )
        titleLabel.text = "请填写真实信息，我们不会泄漏"
        titleLabel.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
