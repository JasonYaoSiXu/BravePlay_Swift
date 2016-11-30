//
//  OrderDetailTicketNumberTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class OrderDetailTicketNumberTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var chooseNumberView: UIView!
    var chooseView : NumberOfTicketsView? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        bgView.backgroundColor = UIColor ( red: 0.1608, green: 0.2314, blue: 0.2392, alpha: 1.0 )
        chooseNumberView.backgroundColor = UIColor.clearColor()
        
        chooseView = NumberOfTicketsView(frame: chooseNumberView.bounds)
        chooseNumberView.addSubview(chooseView!)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
