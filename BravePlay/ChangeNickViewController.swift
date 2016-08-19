//
//  ChangeNickViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ChangeNickViewController: UIViewController {

    private let nickTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.2314, green: 0.3294, blue: 0.3412, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        initTextField()
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
        
        let rightButton = UIBarButtonItem(title: "保存", style: .Done, target: self, action: #selector(ChangeNickViewController.saveChange))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    
    @objc private func saveChange() {
        print("ChangeNickViewController :: \(#function)")
    }

    private func initTextField() {
        nickTextField.frame = CGRect(x: 10, y: 74, width: UIScreen.mainScreen().bounds.size.width - 20, height: 60)
        nickTextField.backgroundColor = UIColor ( red: 0.1373, green: 0.1961, blue: 0.2157, alpha: 1.0 )
        nickTextField.textColor = UIColor.whiteColor()
        nickTextField.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        nickTextField.layer.cornerRadius = 4
        nickTextField.layer.masksToBounds = true
        view.addSubview(nickTextField)
        
        if let nicklable = UserData.UserDatas.nickName {
            nickTextField.text = nicklable
        } else {
            nickTextField.text = "未知"
        }
        nickTextField.becomeFirstResponder()
    }
    
}
