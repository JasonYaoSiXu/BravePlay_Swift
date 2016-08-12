//
//  DetailForTvRecommendTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class DetailForTvRecommendTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var timeLenLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        bgView.backgroundColor = UIColor ( red: 0.1451, green: 0.2039, blue: 0.2196, alpha: 1.0 )
        
        titleImageView.layer.cornerRadius = 4
        titleImageView.layer.masksToBounds = true
        titleImageView.clipsToBounds = true
        titleImageView.contentMode = .ScaleAspectFill
        
        titleLabel.textColor = UIColor ( red: 0.7529, green: 0.7725, blue: 0.7843, alpha: 1.0 )
        typeLabel.textColor = UIColor ( red: 0.3725, green: 0.4196, blue: 0.4431, alpha: 1.0 )
        authorlabel.textColor = UIColor ( red: 0.3725, green: 0.4196, blue: 0.4431, alpha: 1.0 )
        timeLenLabel.textColor = UIColor ( red: 0.3725, green: 0.4196, blue: 0.4431, alpha: 1.0 )
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
