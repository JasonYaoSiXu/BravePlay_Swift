//
//  MineSectionHeadView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

class MineSectionHeadView: UIView {

    var headImageViewUrl: String = "" {
        didSet {
            loadImageView(headImageViewUrl)
        }
    }
    
    var nick: String = "" {
        didSet {
            nickButton.titleLabel?.text = nick
            nickButton.setTitle(nick, forState: .Normal)
        }
    }
    
    var tapImageAction: ((Void) -> Void)?
    var tapSetButtonAction: ((Void) -> Void)?
    var tapNickButotnAction: ((Void) -> Void)?
    
    private let headImageView: UIImageView = UIImageView()
    private let nickButton: UIButton = UIButton()
    private let setButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headImageView)
        backgroundColor = UIColor ( red: 0.1373, green: 0.2118, blue: 0.2431, alpha: 1.0 )
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(headImageView)
        headImageView.snp.makeConstraints(closure: { [unowned self] make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20)
            make.width.equalTo(self.bounds.size.height / 2)
            make.height.equalTo(self.bounds.size.height / 2)
        })
        headImageView.layer.cornerRadius = self.bounds.size.height / 4
        headImageView.layer.masksToBounds = true
        headImageView.clipsToBounds = true
        headImageView.contentMode = .ScaleAspectFill
        headImageView.image = UIImage(named: "find_mw_bg")
        
        headImageView.userInteractionEnabled = true
        let tapHeadImageView = UITapGestureRecognizer(target: self, action: #selector(MineSectionHeadView.tapImageView))
        headImageView.addGestureRecognizer(tapHeadImageView)
        
        addSubview(nickButton)
        nickButton.snp.makeConstraints(closure: { [unowned self] make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.headImageView.snp.right).offset(10)
        })
        nickButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        nickButton.addTarget(self, action: #selector(MineSectionHeadView.tapNickButton), forControlEvents: .TouchUpInside)
        
        addSubview(setButton)
        setButton.snp.makeConstraints(closure: { [unowned self] make in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-20)
        })
        setButton.backgroundColor = UIColor.clearColor()
        setButton.setTitle("设置", forState: .Normal)
        setButton.setTitleColor(UIColor ( red: 0.4627, green: 0.5176, blue: 0.5451, alpha: 1.0 ), forState: .Normal)
        setButton.addTarget(self, action: #selector(MineSectionHeadView.tapSetButton), forControlEvents: .TouchUpInside)
    }
    
    
    private func loadImageView(imageUrl: String) {
        headImageView.setImageWithURL(makeImageURL(imageUrl), defaultImage: UIImage(named: "find_mw_bg"))
    }
    
    @objc private func tapImageView() {
        print("MineSectionHeadView::\(#function)")
        tapImageAction?()
    }
    
    @objc private func tapSetButton() {
        print("MineSectionHeadView::\(#function)")
        tapSetButtonAction?()
    }
    
    @objc private func tapNickButton() {
        print("MineSectionHeadView::\(#function)")
        tapNickButotnAction?()
    }
    
}
