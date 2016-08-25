//
//  TopicsDataCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/24.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class TopicsDataCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var careButton: UIButton!
    
    var action: ((Void) -> Void)?
    var bgImageUrl : String = "" {
        didSet {
            bgImageView.setImageWithURL(makeImageURL(bgImageUrl), defaultImage: UIImage(named: "find_mw_bg"))
        }
    }
    
    var headImageUrl: String = "" {
        didSet {
            headImageView.setImageWithURL(makeImageURL(headImageUrl), defaultImage: UIImage(named: "find_mw_bg"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        
        initSubViews()
    }
    
    @IBAction func tapCareButton(sender: UIButton) {
        action?()
    }
    
    private func initSubViews() {
        bgImageView.layer.cornerRadius = 4
        bgImageView.layer.masksToBounds = true
        bgImageView.clipsToBounds = true
        bgImageView.contentMode = .ScaleAspectFill
        bgImageView.image = UIImage(named: "find_mw_bg")
        
        headImageView.image = UIImage(named: "find_mw_bg")
        headImageView.tintColor = UIColor.whiteColor()
        
        typeLabel.textColor = UIColor.whiteColor()
        typeLabel.text = "户外"
        
        careButton.setTitle("关注", forState: .Normal)
        careButton.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        careButton.layer.cornerRadius = careButton.bounds.size.height / 2
        careButton.layer.masksToBounds = true
        careButton.layer.borderWidth = 1.0
        careButton.layer.borderColor = UIColor.yellowColor().CGColor
    }
    
}
