//
//  SeciontTitleTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/7/29.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class SeciontTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var jumpButton: UIButton!
    
    var action: ((Void) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        setUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI() {
        titleView.backgroundColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        titleLabel.textColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        jumpButton.backgroundColor = UIColor ( red: 0.1412, green: 0.2078, blue: 0.2275, alpha: 1.0 )
        
        titleLabel.text = "敢玩趣闻"
        jumpButton.setTitle("662 >", forState: .Normal)
        jumpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    @IBAction func tapJumpButton(sender: UIButton) {
        print("\(#function)")
        guard let action = self.action else {
            return
        }
        action()
    }
    
}
