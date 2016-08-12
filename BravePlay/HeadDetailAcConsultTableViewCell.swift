//
//  HeadDetailAcConsultTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/3.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class HeadDetailAcConsultTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var leftImageHead: UIImageView!
    @IBOutlet weak var rightImagHead: UIImageView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        
        cellBgView.backgroundColor = UIColor ( red: 0.1569, green: 0.2275, blue: 0.2353, alpha: 1.0 )
        chatView.backgroundColor = UIColor ( red: 0.1529, green: 0.2078, blue: 0.1922, alpha: 1.0 )
        chatView.layer.cornerRadius = 4
        
        leftImageHead.layer.cornerRadius = leftImageHead.bounds.size.height / 2
        leftImageHead.layer.masksToBounds = true
        leftImageHead.clipsToBounds = true
        leftImageHead.contentMode = .ScaleAspectFill
        
        rightImagHead.layer.cornerRadius = rightImagHead.bounds.size.height / 2
        rightImagHead.layer.masksToBounds = true
        rightImagHead.clipsToBounds = true
        rightImagHead.contentMode = .ScaleAspectFill

        nameLabel.textColor = UIColor ( red: 0.3569, green: 0.4118, blue: 0.4157, alpha: 1.0 )
        messageLabel.textColor = UIColor ( red: 0.5765, green: 0.6078, blue: 0.6039, alpha: 1.0 )
        
        nameLabel.text = "yaosixu"
        messageLabel.text = "俯卧撑"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellHeight() -> CGFloat {
        if let text = messageLabel.text {
            return text.heightWithConstrainedWidth(messageLabel.bounds.size.width, font: messageLabel.font) + nameLabel.bounds.height + 20
        }
        return 60
    }
    
}
