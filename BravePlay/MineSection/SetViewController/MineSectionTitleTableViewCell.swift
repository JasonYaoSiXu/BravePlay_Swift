//
//  MineSectionTitleTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineSectionTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        initSubviews()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initSubviews() {
        bgView.backgroundColor = UIColor ( red: 0.1176, green: 0.1686, blue: 0.1922, alpha: 1.0 )
        let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width - 20, height: bgView.bounds.size.height)
        let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.TopLeft,.TopRight], cornerRadii: CGSize(width: 4, height: 4))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bgView.bounds
        maskLayer.path = bezierPath.CGPath
        bgView.layer.mask = maskLayer
        
        titleView.backgroundColor = UIColor ( red: 0.949, green: 0.549, blue: 0.051, alpha: 1.0 )
        
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "个人信息"
    }
    
}
