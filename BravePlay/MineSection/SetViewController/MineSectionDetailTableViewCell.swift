//
//  MineSectionDetailTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineSectionDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var jumpButton: UIButton!
    @IBOutlet weak var operatorName: UILabel!
    @IBOutlet weak var operatorTitle: UILabel!

    var isLastCell: Bool = false {
        didSet {
            if isLastCell {
                let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width - 20, height: bgView.bounds.size.height)
                let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.BottomLeft,.BottomRight], cornerRadii: CGSize(width: 4, height: 4))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = bgView.bounds
                maskLayer.path = bezierPath.CGPath
                bgView.layer.mask = maskLayer
            }
        }
    }
    
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
        bgView.backgroundColor = UIColor ( red: 0.1725, green: 0.2275, blue: 0.2392, alpha: 1.0 )
        
        headImageView.image = UIImage(named: "find_mw_bg")
        headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2
        headImageView.layer.masksToBounds = true
        headImageView.clipsToBounds = true
        headImageView.contentMode = .ScaleAspectFill
        
        jumpButton.setTitleColor(UIColor ( red: 0.6039, green: 0.6353, blue: 0.651, alpha: 1.0 ), forState: .Normal)
        
        operatorName.textColor = UIColor ( red: 0.6039, green: 0.6353, blue: 0.651, alpha: 1.0 )
        operatorName.text = "修改头像"
        
        operatorTitle.textColor = UIColor.whiteColor()
        operatorTitle.text = "修改密码"
    }
    
}
