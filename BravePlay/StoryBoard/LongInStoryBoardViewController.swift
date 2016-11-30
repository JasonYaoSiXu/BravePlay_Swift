//
//  LongInStoryBoardViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class LongInStoryBoardViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wechatLog: UIButton!
    @IBOutlet weak var phoneLog: UIButton!
    @IBOutlet weak var registerButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initSubviews() {
        closeButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Normal)
        closeButton.alpha = 1.0
        
        wechatLog.setTitleColor(UIColor ( red: 0.1294, green: 0.5804, blue: 0.0549, alpha: 1.0 ), forState: .Normal)
        wechatLog.alpha = 1.0
        
        phoneLog.setTitleColor(UIColor ( red: 0.4745, green: 0.3098, blue: 0.1137, alpha: 1.0 ), forState: .Normal)
        phoneLog.alpha = 1.0
        
        registerButton.setTitleColor(UIColor ( red: 0.702, green: 0.698, blue: 0.6784, alpha: 1.0 ), forState: .Normal)
        registerButton.alpha = 1.0
    }
    
    @IBAction func tapCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
