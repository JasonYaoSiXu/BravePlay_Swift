//
//  MineCareDetailCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineCareDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var playImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        initSubViews()
    }
    
    private func initSubViews() {
        coverImageView.layer.cornerRadius = 4
        coverImageView.layer.masksToBounds = true
        coverImageView.clipsToBounds = true
        coverImageView.contentMode = .ScaleAspectFill
        coverImageView.image = UIImage(named: "find_mw_bg")
        
        detailLabel.textColor = UIColor.whiteColor()
        detailLabel.text = "没有不能走的路，比跑车还要厉害的车！"
    }

}
