//
//  OrderDetailPayWaysTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class OrderDetailPayWaysTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var payWayImageView: UIImageView!
    @IBOutlet weak var payNameLabel: UILabel!
    @IBOutlet weak var chooseButton: UIButton!
    
    var isSeleted: Bool = false {
        didSet {
            if isSeleted {
                chooseButton.setImage(UIImage(named: "ticket_buy_click"), forState: .Normal)
            } else {
                chooseButton.setImage(UIImage(named: "ticket_buy_n"), forState: .Normal)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        
        bgView.backgroundColor = UIColor ( red: 0.1608, green: 0.2314, blue: 0.2392, alpha: 1.0 )
        payWayImageView.layer.cornerRadius = payWayImageView.bounds.size.height / 2
        payWayImageView.layer.masksToBounds = true
        payWayImageView.clipsToBounds = true
        payWayImageView.contentMode = .ScaleAspectFill
        payNameLabel.textColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func tapChooseButton(sender: AnyObject) {
        
    }
    
}
