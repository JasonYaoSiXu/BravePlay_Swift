//
//  UserVcViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class UserVcViewController: UIViewController {

    private var headView: UserVcHeadView!
    private let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
    private let screenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1255, green: 0.2118, blue: 0.2588, alpha: 1.0 )
        // Do any additional setup after loading the view.
        
        headView = UserVcHeadView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight / 2 - 30))
        view.addSubview(headView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 0.0
    }
    
}
