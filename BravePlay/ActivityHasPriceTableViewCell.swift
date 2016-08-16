//
//  ActivityHasPriceTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ActivityHasPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var markView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        initUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initUI() {
        bgView.backgroundColor = UIColor.clearColor()
        
        coverImageView.image = UIImage(named: "find_mw_bg")
        coverImageView.layer.cornerRadius = 4
        coverImageView.layer.masksToBounds = true
        coverImageView.clipsToBounds = true
        coverImageView.contentMode = .ScaleAspectFill
        
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.cyanColor()
        titleLabel.text = "缤纷跑，新造型色彩来袭!"
        
        addressLabel.backgroundColor = UIColor.clearColor()
        addressLabel.textColor = UIColor ( red: 0.5608, green: 0.5451, blue: 0.6588, alpha: 1.0 )
        addressLabel.text = "上海"
        
        timeLabel.backgroundColor = UIColor.clearColor()
        timeLabel.textColor = UIColor ( red: 0.5608, green: 0.5451, blue: 0.6588, alpha: 1.0 )
        timeLabel.text = "08月17日"
        
        markView.backgroundColor = UIColor.whiteColor()
        markView.alpha = 0.6
        let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width - 20, height: markView.bounds.height)
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.BottomLeft,.BottomRight], cornerRadii: CGSize(width: 4.0, height: 4.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = markView.bounds
        maskLayer.path = maskPath.CGPath
        markView.layer.mask = maskLayer
        
        priceLabel.backgroundColor = UIColor ( red: 0.1137, green: 0.1255, blue: 0.2235, alpha: 1.0 )
        priceLabel.textColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        priceLabel.text = "¥ 40"
        let path = UIBezierPath(roundedRect: priceLabel.bounds, byRoundingCorners: [.TopLeft,.BottomLeft], cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayers = CAShapeLayer()
        maskLayers.frame = priceLabel.bounds
        maskLayers.path = path.CGPath
        priceLabel.layer.mask = maskLayers
    }
}
