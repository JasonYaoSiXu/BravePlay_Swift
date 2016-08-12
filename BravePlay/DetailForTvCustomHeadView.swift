//
//  DetailForTvCustomHeadView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

class DetailForTvCustomHeadView : UIView {
    private var bottomView: UIView = UIView()
    private let playButton = UIButton()
    let titleLabel = UILabel()
    let timeLabel = UILabel()
    let detailLabel = UILabel()
    let likeButton = UIButton()
    let shareButton = UIButton()
    let imageView = UIImageView()
    var tapButtonActions: ((Void) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor ( red: 0.1725, green: 0.2667, blue: 0.298, alpha: 1.0 )
        setTopView()
        setBottomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTopView() {
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height / 2)
        addSubview(imageView)
        imageView.image = UIImage(named: "find_mw_bg")
        imageView.userInteractionEnabled = true
        
        playButton.setImage(UIImage(named: "播放"), forState: .Normal)
        imageView.addSubview(playButton)
        playButton.snp.makeConstraints(closure: { [unowned self] make in
            make.centerX.equalTo(self.imageView.snp.centerX)
            make.centerY.equalTo(self.imageView.snp.centerY)
        })
        playButton.addTarget(self, action: #selector(DetailForTvCustomHeadView.tapButtonAction), forControlEvents: .TouchUpInside)
    }
    
    @objc private func tapButtonAction() {
        if let action = self.tapButtonActions {
            action()
        }
    }
    
    private func setBottomView() {
        bottomView.frame = CGRect(x: 10, y: frame.size.height / 2, width: frame.size.width - 20, height: frame.size.height / 2)
        bottomView.backgroundColor = UIColor ( red: 0.1608, green: 0.2392, blue: 0.2588, alpha: 1.0 )
        addSubview(bottomView)
        setUIWithSubView()
    }
    
    private func setUIWithSubView() {
        
        bottomView.addSubview(titleLabel)
        bottomView.addSubview(timeLabel)
        bottomView.addSubview(detailLabel)
        bottomView.addSubview(likeButton)
        bottomView.addSubview(shareButton)
        
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "当马奥踩上滑板鞋，这个游戏该怎么玩?"
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(20)
            make.centerX.equalTo(self.bottomView.snp.centerX)
        })
        
        timeLabel.text = "------ Time 2'20 -----"
        timeLabel.textColor = UIColor ( red: 0.3608, green: 0.4275, blue: 0.4392, alpha: 1.0 )
        timeLabel.sizeToFit()
        timeLabel.snp.makeConstraints(closure: { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(titleLabel.snp.centerX)
        })
        
        detailLabel.text = "当马里奥踩上滑板，在狭窄的街道进行闯关，你觉得结局会是如何？ #From CorridorDigtal"
        detailLabel.textColor = UIColor ( red: 0.3608, green: 0.4275, blue: 0.4392, alpha: 1.0 )
        detailLabel.numberOfLines = 2
        detailLabel.snp.makeConstraints(closure: { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        })
        
        likeButton.setTitle("喜欢", forState: .Normal)
        likeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        likeButton.backgroundColor = UIColor ( red: 0.1647, green: 0.2235, blue: 0.2353, alpha: 1.0 )
        likeButton.addTarget(self, action: #selector(DetailForTvCustomHeadView.tapLikeButton), forControlEvents: .TouchUpInside)
        likeButton.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(self.detailLabel.snp.bottom).offset(20)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(self.bottomView.bounds.size.width / 2 - 5)
        })
        
        shareButton.setTitle("分享", forState: .Normal)
        shareButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        shareButton.backgroundColor = UIColor ( red: 0.1647, green: 0.2235, blue: 0.2353, alpha: 1.0 )
        shareButton.addTarget(self, action: #selector(DetailForTvCustomHeadView.tapShareButton), forControlEvents: .TouchUpInside)
        shareButton.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(self.detailLabel.snp.bottom).offset(20)
            make.bottom.equalTo(0)
            make.left.equalTo(self.likeButton.snp.right).offset(5)
            make.width.equalTo(self.bottomView.bounds.size.width / 2)
            })
    }

    
    @objc private func tapLikeButton() {
        
    }
    
    @objc private func tapShareButton() {
        ShardView.show([
            ActionItem("微信") { _ in
                print("分享到微信")
            },
            ActionItem("朋友圈") { _ in
                print("分享到朋友圈")
            },
            ActionItem("QQ") { _ in
                print("QQ")
            },
            ActionItem("微博") { _ in
                print("微博")
            }
            ])
    }

}