//
//  SetDebunkViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class SetDebunkViewController: UIViewController {

    @IBOutlet weak var debunkInfoTextView: UITextView!
    @IBOutlet weak var debunkUserInfoTextField: UITextField!
    @IBOutlet weak var spaceLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.2314, green: 0.3294, blue: 0.3412, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 1.0
        
        navigationController?.navigationBar.barTintColor = UIColor ( red: 0.1059, green: 0.1608, blue: 0.1882, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "修改昵称"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        let rightButton = UIBarButtonItem(title: "发送", style: .Done, target: self, action: #selector(SetDebunkViewController.sendChange))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func sendChange() {
        print("SetDebunkViewController :: \(#function)")
    }
    

    private func setSubviews() {
        spaceLineView.backgroundColor = UIColor ( red: 0.1765, green: 0.2353, blue: 0.2549, alpha: 1.0 )
        
        debunkInfoTextView.backgroundColor = UIColor ( red: 0.2392, green: 0.3373, blue: 0.3412, alpha: 1.0 )
        debunkInfoTextView.tintColor = UIColor ( red: 0.0902, green: 0.6745, blue: 0.9176, alpha: 1.0 )
        
        
        debunkUserInfoTextField.tintColor = UIColor ( red: 0.0902, green: 0.6745, blue: 0.9176, alpha: 1.0 )
        debunkUserInfoTextField.attributedPlaceholder = NSAttributedString(string: "手机号码/微信号/邮箱,方便我们及时给您反馈", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4745, green: 0.5137, blue: 0.5373, alpha: 1.0 )])
        debunkUserInfoTextField.textColor = UIColor.whiteColor()
        debunkUserInfoTextField.backgroundColor = UIColor ( red: 0.2392, green: 0.3373, blue: 0.3412, alpha: 1.0 )
    }
    
}
