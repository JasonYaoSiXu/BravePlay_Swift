//
//  MineTicketInfoTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineTicketInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        initSubView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initSubView() {
        headImageView.image = UIImage(named: "find_mw_bg")
        headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2
        headImageView.layer.masksToBounds = true
        headImageView.clipsToBounds = true
        headImageView.contentMode = .ScaleAspectFill
        
        titleLabel.textColor = UIColor ( red: 0.3255, green: 0.4078, blue: 0.4471, alpha: 1.0 )
        titleLabel.text = "敢玩君回复了您的咨询:"
        
        infoLabel.textColor = UIColor.whiteColor()
        infoLabel.text = "嗨起来!"
        
        timeLabel.textColor = UIColor ( red: 0.3255, green: 0.4078, blue: 0.4471, alpha: 1.0 )
        timeLabel.text = "08-05"
    }
    
}
