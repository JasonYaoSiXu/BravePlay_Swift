//
//  ShareView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/5.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

typealias ActionItem = (imageName:String,action:(Void -> Void)?)

class ShardView : UIView {
    
    private var closeButton = UIButton()
    private let shareToLabel = UILabel()
    private var bgView = UIView()
    private var buttonItems: [ActionItem] = []
    
    class var ShareView : ShardView {
        struct Singleton {
            static let instance = ShardView()
        }
        return Singleton.instance
    }
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        bgView = UIView(frame: CGRect(x: 0, y: bounds.height * 0.7, width: bounds.width, height: bounds.height * 0.3))
        bgView.backgroundColor = UIColor.blackColor()
        addSubview(bgView)
        
        
        shareToLabel.text = "分享到"
        shareToLabel.textColor = UIColor.whiteColor()
        shareToLabel.textAlignment = .Center
        shareToLabel.sizeToFit()
        bgView.addSubview(shareToLabel)
        shareToLabel.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(30)
            make.centerX.equalTo(self.bgView.snp.centerX)
        })
        
        
        bgView.addSubview(closeButton)
        closeButton.setTitle("关闭", forState: .Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton.snp.makeConstraints(closure: { [unowned self] make in
            make.bottom.equalTo(-30)
            make.centerX.equalTo(self.bgView.snp.centerX)
        })
        closeButton.addTarget(self, action: #selector(ShardView.tapCloseButton), forControlEvents: .TouchUpInside)
    }
    
    @objc private func tapCloseButton() {
        bgView.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    private func addButtonToBgView() {
        
        let buttonCounts = buttonItems.count
        let spaceCounts = buttonCounts + 1
        let buttonWidth: CGFloat = bounds.size.width / (2.0 * CGFloat(buttonCounts))
        let spaceWidth: CGFloat = (bounds.size.width - CGFloat(buttonCounts) * buttonWidth) / CGFloat(spaceCounts)
        
        for (index,item) in buttonItems.enumerate() {
            let button = UIButton()
            button.setImage(UIImage(named: item.imageName), forState: .Normal)
            button.tag = index
            button.addTarget(self, action: #selector(ShardView.buttonAciton(_ :)), forControlEvents: .TouchUpInside)
            
            bgView.addSubview(button)
            button.snp.makeConstraints(closure: { [unowned self] make in
                make.left.equalTo(CGFloat(index) * buttonWidth + CGFloat(index + 1) * spaceWidth)
                make.top.equalTo(self.shareToLabel.snp.bottomMargin).offset(10)
            })
        }
        
    }
    
    func buttonAciton(button: UIButton) {
        if button.tag < buttonItems.count {
            buttonItems[button.tag].action?()
        }
    }
    
    func showShare() {
        guard let currentViewController = UIApplication.sharedApplication().keyWindow?.rootViewController else {
            return
        }
        frame = currentViewController.view.bounds
        backgroundColor = UIColor.clearColor()
        currentViewController.view.addSubview(self)
        currentViewController.view.bringSubviewToFront(self)
        setUpUI()
    }
    
    class func show(items: [ActionItem]) {
        let showShare = ShardView.ShareView
        showShare.showShare()
        showShare.buttonItems = items
        showShare.addButtonToBgView()
    }
    
}