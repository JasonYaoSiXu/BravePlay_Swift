//
//  ExtensionUIControl.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/2.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

extension UIImageView {
    func setImageWithURL(url: NSURL, defaultImage: UIImage?) {
//        SDWebImageManager.sharedManager().imageDownloader.maxConcurrentDownloads = 1
        self.sd_setImageWithURL(url, placeholderImage: defaultImage ?? UIImage())
    }
}

extension UIViewController {
    
//    var keyBoardHeight: CGFloat {
//        get {
//            return self.keyBoardHeight
//        }
//        set {
//            self.keyBoardHeight = newValue
//        }
//    }
    
    func showHud(status: String = "") {
        SVProgressHUD.showWithStatus(status)
    }
    
    func popHud() {
        SVProgressHUD.dismiss()
    }
    
    func showErrorMessage(message: String) {
        SVProgressHUD.showErrorWithStatus(message)
    }
    
    func showInfoMessage(message: String) {
        SVProgressHUD.showInfoWithStatus(message)
    }
    
    func dealWithError(error: MyErrorType) {
        SVProgressHUD.showErrorWithStatus(error.description)
    }
    
    func htmlEntityDecode(soucreString: String) -> String {
        return ""
    }
    
    func alterView(titleOne: String, titleTwo: String, titleThree: String,oneAction: ((UIAlertAction) -> Void)?,twoAction: ((UIAlertAction) -> Void)?,threeAction: ((UIAlertAction) -> Void)?) {
        
        let alterView = UIAlertController(title: "请选择", message: "", preferredStyle: .ActionSheet)
        alterView.addAction(UIAlertAction(title: titleOne, style: .Default, handler: oneAction))
        alterView.addAction(UIAlertAction(title: titleTwo, style: .Default, handler: twoAction))
        alterView.addAction(UIAlertAction(title: titleThree, style: .Cancel, handler: threeAction))
        presentViewController(alterView, animated: true, completion: nil)
    }

//    func notificationKeyBoard() {
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyBoardWillHide), name: UIKeyboardWillHideNotification, object: nil)
//    }
//    
//    @objc private func keyBoardWillShow(notification: NSNotification) {
//        
//        guard let userInfo = notification.userInfo else {
//            return
//        }
//        
//        if let value = userInfo[UIKeyboardFrameEndUserInfoKey] {
//            keyBoardHeight = value.CGRectValue.size.height
//        }
//        
//    }
//    
//    @objc private func keyBoardWillHide() {
//        keyBoardHeight = 0
//    }
    
}

extension UITableView {
    
}

func gotoLogIn(presentView: UIViewController) {
    let story = UIStoryboard(name: "LogInStoryBoard", bundle: nil)
    let logVc = story.instantiateViewControllerWithIdentifier("loginStoryBoard") as! LongInStoryBoardViewController
    let navController = UINavigationController(rootViewController: logVc)
    presentView.presentViewController(navController, animated: true, completion:  nil)
}

func dismissLogVc() {
    guard let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController  else {
        return
    }
    rootVC.dismissViewControllerAnimated(false, completion: nil)
}

func makeImageURL(urlStr: String) -> NSURL {
    
    guard let url = NSURL(string: urlStr) else {
        return NSURL()
    }
    
    return url
}
