//
//  ButTicketViewTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/5.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ButTicketViewTableViewCell: UITableViewCell {

    var isChoose:Bool = false {
        didSet {
            if isChoose {
                isChooseImage.image = UIImage(named: "ticket_buy_click")
            } else {
                isChooseImage.image = UIImage(named: "ticket_buy_n")
            }
        }
    }
    
    @IBOutlet weak var isChooseImage: UIImageView!
    @IBOutlet weak var ticketTitleLabel: UILabel!
    @IBOutlet weak var ticketInfolabel: UILabel!
    @IBOutlet weak var ticketPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        self.backgroundColor = UIColor ( red: 0.0902, green: 0.1137, blue: 0.1333, alpha: 1.0 )
        ticketTitleLabel.textColor = UIColor.whiteColor()
        ticketInfolabel.textColor = UIColor ( red: 0.2902, green: 0.3098, blue: 0.3255, alpha: 1.0 )
        ticketPriceLabel.textColor = UIColor ( red: 0.898, green: 0.5804, blue: 0.0549, alpha: 1.0 )
        ticketTitleLabel.text = "单人早鸟票"
        ticketInfolabel.text = "请在备注中选择课程1或2与其"
        ticketPriceLabel.text = "¥190"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
