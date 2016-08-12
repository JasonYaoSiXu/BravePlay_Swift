//
//  ShareViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/5.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shareToLabel: UILabel!
    @IBOutlet weak var imageViewOne: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var imageViewThree: UIImageView!
    @IBOutlet weak var imageViewFour: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        imageViewOne.image = UIImage(named: "微信")
        imageViewTwo.image = UIImage(named: "朋友圈")
        imageViewThree.image = UIImage(named: "QQ")
        imageViewFour.image = UIImage(named: "微博")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
