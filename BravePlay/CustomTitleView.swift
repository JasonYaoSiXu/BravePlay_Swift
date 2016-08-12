//
//  CustomTitleView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

class CustomTitleView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var titleString: String = "活动详情" {
        didSet {
            titleLabel.text = titleString
            titleLabel.sizeToFit()
        }
    }
    
    private let customBgView: UIView = UIView()
    private let titleView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubViews() {
        addSubview(customBgView)
        customBgView.snp.makeConstraints(closure: { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        })
        customBgView.backgroundColor = UIColor ( red: 0.1059, green: 0.1216, blue: 0.1333, alpha: 1.0 )
        
        customBgView.addSubview(titleView)
        titleView.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(10)
            make.centerY.equalTo(self.customBgView.snp.centerY)
            make.height.equalTo(self.bounds.size.height / 2)
            make.width.equalTo(3)
        })
        titleView.backgroundColor = UIColor ( red: 0.9765, green: 0.6118, blue: 0.051, alpha: 1.0 )
        
        customBgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints(closure: { [unowned self] make in
            make.centerY.equalTo(self.customBgView.snp.centerY)
            make.left.equalTo(self.titleView.snp.right).offset(10)
        })
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "活动详情"
    }

}
