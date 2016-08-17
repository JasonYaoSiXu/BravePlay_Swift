//
//  MineSetViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineSetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor ( red: 0.2118, green: 0.3098, blue: 0.3216, alpha: 1.0 )
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
        
        navigationController?.navigationBar.barTintColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "设置"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        let rightButton = UIBarButtonItem(title: "退出", style: .Done, target: self, action: #selector(MineSetViewController.logOutAction))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.hidden = true
        navigationController?.navigationBar.alpha = 0.0
    }
    
    @objc private func logOutAction() {
        print("MineSetViewController::\(#function)")
    }

}
