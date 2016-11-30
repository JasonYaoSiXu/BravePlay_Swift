//
//  DetailForTvCommentTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class DetailForTvCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        bgView.backgroundColor = UIColor ( red: 0.1451, green: 0.2039, blue: 0.2196, alpha: 1.0 )
        
        headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2
        headImageView.layer.masksToBounds = true
        headImageView.clipsToBounds = true
        headImageView.contentMode = .ScaleAspectFill
        
        nickLabel.textColor = UIColor.whiteColor()
        timeLabel.textColor = UIColor ( red: 0.4392, green: 0.4824, blue: 0.4941, alpha: 1.0 )
        bodyLabel.textColor = UIColor ( red: 0.4392, green: 0.4824, blue: 0.4941, alpha: 1.0 )
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
