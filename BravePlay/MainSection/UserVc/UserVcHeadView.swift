//
//  UserVcHeadView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

class UserVcHeadView: UIView {

    ///图像的url
    var headImageUrl: String = "" {
        didSet {
            setImageForHeadImageView(headImageUrl)
        }
    }
    
    ///昵称
    var nick: String = "" {
        didSet {
            nickLabel.text = nick
            nickLabel.sizeToFit()
        }
    }
    
    ///简介/Users/yaosixu/Desktop/工作周报
    var introduce: String = "" {
        didSet {
            introduceLabel.text = introduce
        }
    }
    
    var tapCareButtonAction: ((Void) -> Void)?
    
    ///头像
    private let headImageView: UIImageView = UIImageView()
    ///昵称
    private let nickLabel: UILabel = UILabel()
    ///简介
    private let introduceLabel: UILabel = UILabel()
    private let careButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor ( red: 0.2353, green: 0.2471, blue: 0.2471, alpha: 1.0 )
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setImageForHeadImageView(headImageUrl: String) {
        headImageView.setImageWithURL(makeImageURL(headImageUrl), defaultImage: UIImage(named: "find_mw_bg"))
    }
    
    private func addSubViews() {
        addSubview(headImageView)
        headImageView.snp.makeConstraints(closure: { [unowned self] make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(64)
            make.width.equalTo(self.bounds.size.width / 5)
            make.height.equalTo(self.bounds.size.width / 5)
        })
        headImageView.layer.cornerRadius = self.bounds.size.width / 10
        headImageView.layer.masksToBounds = true
        headImageView.clipsToBounds = true
        headImageView.contentMode = .ScaleAspectFill
        headImageView.image = UIImage(named: "find_mw_bg")
        
        addSubview(nickLabel)
        nickLabel.snp.makeConstraints(closure: { [unowned self] make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.headImageView.snp.bottom).offset(20)
        })
        nickLabel.font = UIFont(name: "Helvetica", size: 20)
        nickLabel.backgroundColor = UIColor.clearColor()
        nickLabel.textAlignment = .Center
        nickLabel.text = "敢玩"
        nickLabel.textColor = UIColor.whiteColor()
        
        addSubview(introduceLabel)
        introduceLabel.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(self.nickLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(40)
            make.right.equalTo(-40)
        })
        introduceLabel.numberOfLines = 2
        introduceLabel.font = UIFont(name: "Helvetica", size: 14)
        introduceLabel.textColor = UIColor ( red: 0.5098, green: 0.5137, blue: 0.5176, alpha: 1.0 )
        introduceLabel.textAlignment = .Center
        introduceLabel.backgroundColor = UIColor.clearColor()
        introduceLabel.text = "极限户外视频平台官方帐号。微博:@iDarex敢玩微信:iDareX"
        
        addSubview(careButton)
        careButton.snp.makeConstraints(closure: { [unowned self] make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.introduceLabel.snp.bottom).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(25)
        })
        let buttonTitle = NSAttributedString(string: "＋关注", attributes: [NSFontAttributeName: UIFont(name: "Helvetica", size: 15)!,NSForegroundColorAttributeName : UIColor ( red: 0.9529, green: 0.6118, blue: 0.051, alpha: 1.0 )])
        careButton.backgroundColor = UIColor ( red: 0.1804, green: 0.1882, blue: 0.1922, alpha: 1.0 )
        careButton.setAttributedTitle(buttonTitle, forState: .Normal)
        careButton.layer.cornerRadius = 12.5
        careButton.layer.masksToBounds = true
        careButton.layer.borderWidth = 1
        careButton.layer.borderColor = UIColor ( red: 0.9529, green: 0.6118, blue: 0.051, alpha: 1.0 ).CGColor
        careButton.addTarget(self, action: #selector(UserVcHeadView.tapCareButton), forControlEvents: .TouchUpInside)
    }
    
    @objc private func tapCareButton() {
        print("UserVcHeadView::\(#function)")
        tapCareButtonAction?()
    }
    
}
