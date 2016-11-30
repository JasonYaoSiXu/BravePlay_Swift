//
//  OrderDetailTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        
        bgView.backgroundColor = UIColor ( red: 0.1608, green: 0.2314, blue: 0.2392, alpha: 1.0 )
        nameLabel.textColor = UIColor.whiteColor()
        remarkLabel.textColor = UIColor ( red: 0.4314, green: 0.4902, blue: 0.502, alpha: 1.0 )
        pricelabel.textColor = UIColor ( red: 0.9333, green: 0.6, blue: 0.051, alpha: 1.0 )
        
        nameLabel.text = "单人早鸟票"
        remarkLabel.text = "请在备注中选择课程1或课程2与其它必选项"
        pricelabel.text = "¥190"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
