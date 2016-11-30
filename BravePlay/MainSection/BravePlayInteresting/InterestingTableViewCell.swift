//
//  InterestingTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/7/29.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class InterestingTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleInfoLabel: UILabel!
    @IBOutlet weak var authorTimeLabel: UILabel!
    @IBOutlet weak var lookTimesLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        bgView.backgroundColor = UIColor ( red: 0.1765, green: 0.2392, blue: 0.251, alpha: 1.0 )
        bgView.layer.cornerRadius = 4
        bgView.layer.masksToBounds = true
        bottomView.backgroundColor = UIColor.clearColor()
        
        setUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI() {
        titleImageView.image = UIImage(named: "find_mw_bg")
        titleImageView.layer.cornerRadius = 4
        titleImageView.layer.masksToBounds = true
        titleImageView.clipsToBounds = true
        titleImageView.contentMode = .ScaleAspectFill
        
        titleInfoLabel.textColor = UIColor.whiteColor()
        titleInfoLabel.text = "70岁才拿起画笔的中国老太，在香港开画展，从未学过绘画，作品却被世人。。。"
        titleInfoLabel.numberOfLines = 2
        
        authorTimeLabel.textColor = UIColor ( red: 0.3765, green: 0.4314, blue: 0.4431, alpha: 1.0 )
        authorTimeLabel.text = "by yaosixu | 07-29"
        
        lookTimesLabel.textColor = UIColor ( red: 0.3765, green: 0.4314, blue: 0.4431, alpha: 1.0 )
        lookTimesLabel.text = "9999次"
    }
    
}
