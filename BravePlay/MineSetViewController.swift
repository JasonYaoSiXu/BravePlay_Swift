//
//  MineSetViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Alamofire

class MineSetViewController: UIViewController {

    private var imagePicker = UIImagePickerController()
    private let titleCellIdentifier: String = "MineSectionTitleTableViewCell"
    private let detailCellIdentifier: String = "MineSectionDetailTableViewCell"
    private let titleArray: [String] = ["个人信息","帐号信息","其它"]
    private let operatorName: [String] = ["修改头像","修改昵称"]
    private let cellTitle: [String] = ["喜欢敢玩，给好评","我有意见，去吐槽","我有项目，来合作","清除缓存"]
    
    private let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor ( red: 0.1255, green: 0.2118, blue: 0.2588, alpha: 1.0 )
        initTableView()
        NSNotificationCenter.defaultCenter().addObserverForName(Notification.ChangeNick.rawValue, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { [unowned self] _ in
                self.tableView.beginUpdates()
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow:2,inSection:0)], withRowAnimation: .None)
                self.tableView.endUpdates()
        })
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
        UserData.UserDatas.userLogOut()
        navigationController?.popViewControllerAnimated(true)
        NSNotificationCenter.defaultCenter().postNotificationName(Notification.LogOutSuccess.rawValue, object: nil)
    }

    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 74, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 10)
        view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor ( red: 0.1255, green: 0.2118, blue: 0.2588, alpha: 1.0 )
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .SingleLineEtched
        
        var nib = UINib(nibName: titleCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: titleCellIdentifier)
        nib = UINib(nibName: detailCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: detailCellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func sourceType(type: Int, imagePicker: UIImagePickerController) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        if type == 0 {
            imagePicker.sourceType = .PhotoLibrary
        } else if type == 1 {
            imagePicker.sourceType = .Camera
        }
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension MineSetViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 5
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch (indexPath.section, indexPath.row) {
        case (_ ,0):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(titleCellIdentifier, forIndexPath: indexPath) as? MineSectionTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = titleArray[indexPath.section]
            return cell
        default:
            guard let cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: indexPath) as? MineSectionDetailTableViewCell else {
                return UITableViewCell()
            }
            
            switch indexPath.section {
            case 0:
                if indexPath.row == 1 {
                    cell.operatorTitle.hidden = true
                    cell.headImageView.setImageWithURL(makeImageURL(UserData.UserDatas.avatar!), defaultImage: UIImage(named: "find_mw_bg"))
                } else {
                    cell.headImageView.hidden = true
                    cell.isLastCell = true
                    cell.operatorTitle.text = UserData.UserDatas.nickName!
                }
                cell.operatorName.text = operatorName[indexPath.row - 1]
            case 1:
                cell.headImageView.hidden = true
                cell.isLastCell = true
                cell.operatorName.hidden = true
                cell.operatorTitle.text = "修改密码"
            default:
                cell.operatorName.text = "0.0M"
                cell.headImageView.hidden = true
                if indexPath.row == 4 {
                    cell.isLastCell = true
                    cell.operatorName.hidden = false
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        let path = getCachesPath()
                        cell.operatorName.text = getCacheSizeAtPath(path) + "M"
                    })
                } else {
                    cell.isLastCell = false
                    cell.operatorName.hidden = true
                }
                cell.operatorTitle.text = cellTitle[indexPath.row - 1]
            }
            return cell 
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (_, 0):
            return 44
        default:
            return 60
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 15))
        footerView.backgroundColor = UIColor.clearColor()
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch  (indexPath.section, indexPath.row) {
        case (0,1):
            alterView("拍照", titleTwo: "从相册选择", titleThree: "取消", oneAction: { [unowned self] _ in
                self.sourceType(1, imagePicker: self.imagePicker)
                }, twoAction: { [unowned self] _ in
                self.sourceType(0, imagePicker: self.imagePicker)
                }, threeAction: { [unowned self] _ in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        case (0,2):
            let changeNick = ChangeNickViewController()
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(changeNick, animated: true)
        case (1,1):
            let changePassword = SetChangePasswordViewController()
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(changePassword, animated: true)
        case (2,1):
            if let url = NSURL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=com.yinyueapp.livehouse&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8") {
                UIApplication.sharedApplication().openURL(url)
            } else {
                let url = NSURL()
                UIApplication.sharedApplication().openURL(url)
            }
        case (2,2):
            let debunk = SetDebunkViewController(nibName: "SetDebunkViewController", bundle: nil)
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(debunk, animated: true)
        case (2,4):
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                clearCache(getCachesPath())
                dispatch_async(dispatch_get_main_queue(), { [unowned self] _ in
                    self.showInfoMessage("清理成功")
                    tableView.beginUpdates()
                    tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 4, inSection: 2)], withRowAnimation: .None)
                    tableView.endUpdates()
                })
            })
            
        default:
            return
        }
    }
    
}

extension MineSetViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let indexPath = NSIndexPath(forRow: 1, inSection: 0)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? MineSectionDetailTableViewCell else {
            return
        }
        cell.headImageView.image = image
        
        if let destImage = UIImageJPEGRepresentation(image!, 0.01) {
            let date = NSDate()
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "yyyy年MM月dd日hh时MM"
            let path = dateFormat.stringFromDate(date)
            self.qinius(path)
            Alamofire.upload(.PUT, "https://api.idarex.com/users/_current?scenario=avatar",headers: ["Authorization":"Bearer  \(UserData.UserDatas.access_token!)","Accept":"application/json; version=v3"], multipartFormData: { (data) in
                let imageName = "avatar=FmQoW5GvMl7zuOIOw40q4u5nfysx"
                data.appendBodyPart(data: imageName.dataUsingEncoding(NSUTF8StringEncoding)!, name: "")
                data.appendBodyPart(data: destImage, name: "file", mimeType: "image/jpeg")
            }) { (result) in
                print("数据准备完成；")
                switch result {
                case .Success(let upload, _, _):
                    upload.responseString(completionHandler: {(respone) in
                        print("success::\(respone)")
                    })
                case .Failure(let err):
                    print("Error::\(err)")
                    break
                }
            }
        }
    }
    
    private func qinius(avater: String) {
        
        mineSectionProvider.request(MineSection.ChangeAvater, completion: { result in
            print("\(#function) :: result: \(result)")
        })
        
    }
}