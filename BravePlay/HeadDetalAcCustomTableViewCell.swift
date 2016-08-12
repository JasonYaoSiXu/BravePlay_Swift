//
//  HeadDetalAcCustomTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/3.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class HeadDetalAcCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var bgUIView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        
        bgUIView.backgroundColor = UIColor ( red: 0.1608, green: 0.2314, blue: 0.2392, alpha: 1.0 )
        titleLabel.backgroundColor = UIColor ( red: 0.1137, green: 0.1608, blue: 0.1843, alpha: 1.0 )
        titleLabel.textColor = UIColor ( red: 0.7373, green: 0.4549, blue: 0.0667, alpha: 1.0 )
        titleLabel.textAlignment = .Center
        infoLabel.backgroundColor = UIColor.clearColor()
        infoLabel.textColor = UIColor.whiteColor()
        
        let rect = CGRect(x: 0, y: 0, width: titleLabel.bounds.width - 20, height: titleLabel.bounds.height)
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.TopRight,.BottomRight], cornerRadii: CGSize(width: titleLabel.bounds.height / 2, height: titleLabel.bounds.height / 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = titleLabel.bounds
        maskLayer.path = maskPath.CGPath
        titleLabel.layer.mask = maskLayer
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellHeight() -> CGFloat {
        guard let text = infoLabel.text else {
            return 60
        }
    
        return text.heightWithConstrainedWidth(infoLabel.bounds.width, font: infoLabel.font) + titleLabel.bounds.height + 20
    }
    
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
}


