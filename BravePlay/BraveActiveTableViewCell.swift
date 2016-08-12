//
//  BraveActiveTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class BraveActiveTableViewCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        setUI()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUI () {
        bgImageView.layer.cornerRadius = 4
        bgImageView.layer.masksToBounds = true
        bgImageView.clipsToBounds = true
        bgImageView.contentMode = .ScaleAspectFill
        bgImageView.image = UIImage(named: "find_mw_bg")
        bgView.backgroundColor = UIColor ( red: 0.4275, green: 0.3843, blue: 0.3059, alpha: 1.0 )
        
        //  Mark 为指定的UIView的指定的角添加指定的添加圆角效果
        let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width - 20, height: bgView.bounds.height)
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.BottomLeft,.BottomRight], cornerRadii: CGSize(width: 4.0, height: 4.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bgView.bounds
        maskLayer.path = maskPath.CGPath
        bgView.layer.mask = maskLayer
        
        priceLabel.textColor = UIColor ( red: 0.9451, green: 0.6078, blue: 0.0471, alpha: 1.0 )
        priceLabel.text = "¥500"
        titleLabel.text = "北京超体跑酷公社暑期班正式开营！"
        titleLabel.textColor = UIColor.whiteColor()
        addressLabel.text = "北京"
        addressLabel.textColor = UIColor ( red: 0.549, green: 0.5451, blue: 0.4392, alpha: 1.0 )
    }
    
}
