//
//  UserCustomTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/15.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class UserCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var midLineView: UIView!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        initUI()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initUI() {
        timeLabel.textColor = UIColor ( red: 0.5451, green: 0.5804, blue: 0.5961, alpha: 1.0 )
        timeLabel.backgroundColor = UIColor ( red: 0.1059, green: 0.1647, blue: 0.2, alpha: 1.0 )
        timeLabel.layer.cornerRadius = timeLabel.bounds.size.height / 2
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.borderWidth = 1
        timeLabel.layer.borderColor = UIColor ( red: 0.3176, green: 0.3725, blue: 0.4, alpha: 1.0 ).CGColor
        
        topLineView.backgroundColor = UIColor ( red: 0.349, green: 0.4392, blue: 0.4549, alpha: 1.0 )
        midLineView.backgroundColor = UIColor ( red: 0.349, green: 0.4392, blue: 0.4549, alpha: 1.0 )
        bottomLineView.backgroundColor = UIColor ( red: 0.349, green: 0.4392, blue: 0.4549, alpha: 1.0 )
        
        coverImageView.layer.cornerRadius = 4
        coverImageView.layer.masksToBounds = true
        coverImageView.clipsToBounds = true
        coverImageView.contentMode = .ScaleAspectFill
        
        titleLabel.textColor = UIColor.whiteColor()
        nameLabel.textColor = UIColor ( red: 0.7255, green: 0.7373, blue: 0.8157, alpha: 1.0 )
        timeInfoLabel.textColor = UIColor ( red: 0.7255, green: 0.7373, blue: 0.8157, alpha: 1.0 )
    }
    
}
