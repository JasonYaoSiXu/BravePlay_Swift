//
//  SetPasswordTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class SetPasswordTableViewCell: UITableViewCell {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showButton: UIButton!
    
    private var isShow: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        passwordTextField.secureTextEntry = true
        passwordTextField.textColor = UIColor.whiteColor()
        passwordTextField.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        showButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showButtonAction(sender: UIButton) {
        isShow = !isShow
        
        if isShow {
            showButton.setTitle("隐藏", forState: .Normal)
        } else {
            showButton.setTitle("显示", forState: .Normal)
        }
        
        passwordTextField.secureTextEntry = !isShow
    }
    
}
