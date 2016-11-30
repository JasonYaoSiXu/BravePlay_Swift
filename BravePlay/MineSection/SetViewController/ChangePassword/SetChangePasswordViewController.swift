//
//  SetChangePasswordViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class SetChangePasswordViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    private let cellIdentifier: String = "SetPasswordTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.2314, green: 0.3294, blue: 0.3412, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        initTableView()
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
        titleLabel.text = "更改密码"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        let rightButton = UIBarButtonItem(title: "保存", style: .Done, target: self, action: #selector(SetChangePasswordViewController.saveChange))
        navigationItem.rightBarButtonItem = rightButton
    }

    
    @objc private func saveChange() {
        guard let oldPasswordCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? SetPasswordTableViewCell else {
            return
        }
        
        guard let newOnePasswordCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? SetPasswordTableViewCell else {
            return
        }
        
        guard let newTwoPasswordCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as? SetPasswordTableViewCell else {
            return
        }

        if newOnePasswordCell.passwordTextField.text != newTwoPasswordCell.passwordTextField.text && newOnePasswordCell.passwordTextField.text?.characters.count != 0 {
            showErrorMessage("两次输入的密码不一致")
            return
        } else if newOnePasswordCell.passwordTextField.text == oldPasswordCell.passwordTextField.text {
            showErrorMessage("新密码不能和旧密码相同")
            return
        } else if oldPasswordCell.passwordTextField.text?.characters.count == 0 {
            showErrorMessage("请输入旧密码")
            return
        }
        changePassword(oldPasswordCell.passwordTextField.text!, password: newOnePasswordCell.passwordTextField.text!)
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 10, y: 74, width: UIScreen.mainScreen().bounds.size.width - 20, height: 135 )
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor ( red: 0.1373, green: 0.1961, blue: 0.2157, alpha: 1.0 )
        tableView.layer.cornerRadius = 4
        tableView.layer.masksToBounds = true
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
}

extension SetChangePasswordViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? SetPasswordTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension SetChangePasswordViewController {
    
    private func changePassword(old_password: String,password: String) {
        mineSectionProvider.request(MineSection.ChangePassword(access_token: UserData.UserDatas.access_token!, old_password: old_password, password: password), completion: { [unowned self] result in
            self.showHud("正在修改")
            switch result {
            case .Success(let data):
                if data.statusCode == 201 {
                    self.showInfoMessage("修改成功")
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    self.dealWithError(MyErrorType.ResultErrorCode(code: data.statusCode))
                }
            case .Failure:
                self.showErrorMessage("修改失败请重试!")
            }
        })
    }
    
}

