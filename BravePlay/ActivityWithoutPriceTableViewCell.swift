//
//  ActivityWithoutPriceTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ActivityWithoutPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var markView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        bgView.backgroundColor = UIColor.clearColor()
        
        markView.layer.cornerRadius = 4
        markView.layer.masksToBounds = true
        
        bgImageView.layer.cornerRadius = 4
        bgImageView.layer.masksToBounds = true
        bgImageView.clipsToBounds = true
        bgImageView.contentMode = .ScaleAspectFill
        bgImageView.image = UIImage(named: "find_mw_bg")
        
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "乘坐固定翼飞机，敢玩带你飞上天！"
        
        addressLabel.backgroundColor = UIColor.clearColor()
        addressLabel.textColor = UIColor.whiteColor()
        addressLabel.text = "北京"
        
        timeLabel.backgroundColor = UIColor.clearColor()
        timeLabel.textColor = UIColor.whiteColor()
        timeLabel.text = "平日"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
