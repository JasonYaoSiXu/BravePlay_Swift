//
//  HeadDetailAcCustomView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/3.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class HeadDetailAcCustomView : UIView {
    
    var circleImageView: UIImageView = UIImageView()
    var authorLabel: UILabel = UILabel()
    var activityInfo: UILabel = UILabel()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.frame = frame
        backgroundColor = UIColor.clearColor()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        let bgView = UIView(frame: CGRect(x: 0, y: frame.size.height / 2, width: frame.size.width, height: frame.size.height / 2))
        bgView.backgroundColor = UIColor.blackColor()
        bgView.alpha = 0.6
        addSubview(bgView)
        
        circleImageView.frame.size = CGSize(width: 30, height: 30)
        circleImageView.frame.origin = CGPoint(x: 20, y: bgView.frame.origin.y - circleImageView.bounds.height / 2)
        circleImageView.image = UIImage(named: "find_mw_bg")
        circleImageView.layer.cornerRadius = circleImageView.bounds.height / 2
        circleImageView.layer.masksToBounds = true
        circleImageView.clipsToBounds = true
        circleImageView.contentMode = .ScaleAspectFill
        addSubview(circleImageView)
        
        authorLabel.frame.origin = CGPoint(x: 60, y: bgView.frame.origin.y + 5)
        authorLabel.frame.size = CGSize(width: frame.size.width - authorLabel.frame.origin.x, height: 10)
        authorLabel.font = UIFont(name: "Farah", size: 14)
        authorLabel.textColor = UIColor ( red: 0.6275, green: 0.4745, blue: 0.3961, alpha: 1.0 )
        authorLabel.text = "by yaosixu"
//        authorLabel.sizeToFit()
        addSubview(authorLabel)
        
        activityInfo.frame.origin = CGPoint(x: 20, y: bgView.frame.origin.y + 20)
        activityInfo.frame.size = CGSize(width: frame.size.width - activityInfo.frame.origin.x, height: 20)
        activityInfo.textColor = UIColor.whiteColor()
        activityInfo.font = UIFont(name: "Farah", size: 18)
        activityInfo.text = "泥泞跑MudRun强势登陆上海!"
//        activityInfo.sizeToFit()
        addSubview(activityInfo)
    }
    
}