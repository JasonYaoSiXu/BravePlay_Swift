//
//  MineCareTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineCareTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var customCollectionView: UICollectionView!
    
    private let collectionCellIdentifier: String = "MineCareDetailCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        initSubviews()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initSubviews() {
        bgView.backgroundColor = UIColor ( red: 0.1725, green: 0.2039, blue: 0.2392, alpha: 1.0 )
        bgView.layer.cornerRadius = 4
        bgView.layer.masksToBounds = true
        
        headImageView.layer.cornerRadius = headImageView.bounds.size.height / 2
        headImageView.layer.masksToBounds = true
        headImageView.clipsToBounds = true
        headImageView.contentMode = .ScaleAspectFill
        headImageView.image = UIImage(named: "find_mw_bg")
        
        typeLabel.textColor = UIColor.whiteColor()
        typeLabel.text = "机车"
        
        initCollectionView()
    }
    
    private func initCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .Horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.itemSize = CGSize(width: bgView.bounds.size.width / 2.5, height: 80)
        
        customCollectionView.collectionViewLayout = collectionViewLayout
        customCollectionView.showsHorizontalScrollIndicator = false
        customCollectionView.backgroundColor = UIColor ( red: 0.1725, green: 0.2039, blue: 0.2392, alpha: 1.0 )
        
        let nib = UINib(nibName: collectionCellIdentifier, bundle: nil)
        customCollectionView.registerNib(nib, forCellWithReuseIdentifier: collectionCellIdentifier)
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
    }
    
}


extension MineCareTableViewCell :  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifier, forIndexPath: indexPath) as? MineCareDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
}

