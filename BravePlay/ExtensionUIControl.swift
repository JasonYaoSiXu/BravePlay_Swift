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
        showInfoMessage(error.description)
    }
    
    func htmlEntityDecode(soucreString: String) -> String {
        return ""
    }
    
}

extension UITableView {
    
}



func makeImageURL(urlStr: String) -> NSURL {
    
    guard let url = NSURL(string: urlStr) else {
        return NSURL()
    }
    
    return url
}
