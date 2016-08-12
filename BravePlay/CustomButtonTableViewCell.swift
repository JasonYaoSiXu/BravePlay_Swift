//
//  CustomButtonTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/5.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class CustomButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var jumpButton: UIButton!
    var action: ((Void) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        jumpButton.backgroundColor = UIColor ( red: 0.1059, green: 0.1529, blue: 0.1804, alpha: 1.0 )
        jumpButton.setTitleColor(UIColor ( red: 0.9059, green: 0.5294, blue: 0.0588, alpha: 1.0 ), forState: .Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func jumpButton(sender: AnyObject) {
        
        guard let action = self.action else {
            return
        }
        action()
    }
    
    
}
