//
//  BraveTVUITableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class BraveTVUITableViewCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var action: ((Void) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        
        setUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setUI() {
        bgImageView.layer.cornerRadius = 4
        bgImageView.layer.masksToBounds = true
        bgImageView.clipsToBounds = true
        bgImageView.contentMode = .ScaleAspectFill
        bgImageView.image = UIImage(named: "login_bg")
        
        bgImageView.userInteractionEnabled = true
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(BraveTVUITableViewCell.tapImageView))
        bgImageView.addGestureRecognizer(tapImageView)
        
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.backgroundColor = UIColor.clearColor()
        
        nameLabel.textAlignment = .Center
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.backgroundColor = UIColor.clearColor()
    }
    
    @objc private func tapImageView() {
        guard let action = self.action else {
            return
        }
        action()
    }
    
}
