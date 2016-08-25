//
//  BottomView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/11.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

class BottomView: UIView {
    
    private let headImageView = UIImageView()
    private let messageInfoTextField = UITextField()
    private let sendMessageButton = UIButton()
    private let shareButton = UIButton()
    
    var sendMessageAction: ((Void) -> Void)?
    var sharedAction: ((Void) -> Void)?
    
    deinit {
        print("BottomView deinit")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor ( red: 0.051, green: 0.0431, blue: 0.0431, alpha: 1.0 )
        addTopLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTopLine() {
        let topLine: UIView = UIView()
        addSubview(topLine)
        topLine.backgroundColor = UIColor ( red: 0.149, green: 0.1412, blue: 0.1412, alpha: 1.0 )
        topLine.snp.makeConstraints(closure: { make in
            make.top.equalTo(-1)
            make.height.equalTo(1)
            make.left.equalTo(0)
            make.right.equalTo(0)
        })
        addHeadImageView()
    }
    
    private func addHeadImageView() {
        addSubview(headImageView)
        headImageView.image = UIImage(named: "find_mw_bg")
        headImageView.clipsToBounds = true
        headImageView.contentMode = .ScaleAspectFill
        headImageView.snp.makeConstraints(closure: { [unowned self]  make  in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20)
            make.width.equalTo(self.bounds.size.height / 2)
            make.height.equalTo(self.bounds.size.height / 2)
        })
        headImageView.layer.cornerRadius = bounds.size.height / 4
        headImageView.layer.masksToBounds = true
        
        let spaceView = UIView()
        addSubview(spaceView)
        spaceView.snp.makeConstraints(closure: { [unowned self] make in
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(3)
            make.height.equalTo(self.bounds.size.height / 3)
            make.left.equalTo(self.headImageView.snp.right).offset(20)
        })
        spaceView.backgroundColor = UIColor ( red: 0.9373, green: 0.5373, blue: 0.0353, alpha: 1.0 )
        addMessageInfoTextField()
    }
    
    private func addMessageInfoTextField() {
        addSubview(messageInfoTextField)
        messageInfoTextField.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(self.headImageView.snp.right).offset(40)
            make.right.equalTo(-self.bounds.size.width / 2)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(self.bounds.size.height / 2)
        })
        messageInfoTextField.placeholder = "随便说点什么"
        let label = messageInfoTextField.valueForKey("placeholderLabel") as? UILabel
        label?.textColor = UIColor ( red: 0.4706, green: 0.4588, blue: 0.4627, alpha: 1.0 )
        messageInfoTextField.textColor = UIColor.whiteColor()
        messageInfoTextField.tintColor = UIColor.whiteColor()
        
        addTapButton()
    }
    
    private func addTapButton() {
        addSubview(sendMessageButton)
        shareButton.addTarget(self, action: #selector(BottomView.tapShareButton), forControlEvents: .TouchUpInside)
        sendMessageButton.addTarget(self, action: #selector(BottomView.tapSendButton), forControlEvents: .TouchUpInside)
        
        sendMessageButton.snp.makeConstraints(closure: { [unowned self] make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.bounds.size.width / 2)
            make.right.equalTo(-70)
            make.height.equalTo(self.bounds.size.height / 2)
            })
        sendMessageButton.setTitle("发弹幕", forState: .Normal)
        sendMessageButton.setTitleColor(UIColor ( red: 0.6196, green: 0.3961, blue: 0.051, alpha: 1.0 ), forState: .Normal)
        sendMessageButton.layer.cornerRadius = bounds.size.height / 4
        sendMessageButton.layer.masksToBounds = true
        sendMessageButton.layer.borderColor = UIColor ( red: 0.6196, green: 0.3961, blue: 0.051, alpha: 1.0 ).CGColor
        sendMessageButton.layer.borderWidth = 1
        
        let spaceLine = UIView()
        spaceLine.backgroundColor = UIColor ( red: 0.149, green: 0.1373, blue: 0.1373, alpha: 1.0 )
        addSubview(spaceLine)
        spaceLine.snp.makeConstraints(closure: { [unowned self] make in
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(1)
            make.height.equalTo(self.bounds.size.height / 2)
            make.left.equalTo(self.sendMessageButton.snp.right).offset(2)
            })
        
        addSubview(shareButton)
        shareButton.setTitle("分享", forState: .Normal)
        shareButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        shareButton.backgroundColor = UIColor.clearColor()
        shareButton.snp.makeConstraints(closure: { [unowned self] make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(spaceLine.snp.right).offset(5)
            make.right.equalTo(0)
        })
    }
    
    
    @objc private func tapSendButton() {
        print("\(#function)")
        sendMessageAction?()
    }
    
    
    @objc func tapShareButton() {
        print("\(#function)")
        sharedAction?()
    }
    
}
