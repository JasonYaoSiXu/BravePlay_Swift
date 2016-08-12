//
//  CustomTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate: class {
    func showInfoWithCh(indexPath: Int) -> ChnnelItem
    func showInfoWithTop(indexPath: Int) -> TopicItem
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var customCollectionView: UICollectionView!
    private let cellIdentifier = "BottomCollectionViewCell"
    weak var delegate: CustomTableViewCellDelegate!
    var isLastSection: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        
        setUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUI() {
        guard let flowLayout = customCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.itemSize = CGSize(width: 110, height: 110)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        
        customCollectionView.showsHorizontalScrollIndicator = false
        customCollectionView.backgroundColor = UIColor.clearColor()
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        customCollectionView.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
    }
    
    func reloadData() {
        customCollectionView.reloadData()
    }
    
}

extension CustomTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? BottomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if !isLastSection {
            let message = delegate.showInfoWithCh(indexPath.row)
            cell.hasCor = true
            cell.headImg.setImageWithURL(makeImageURL(message.headimg), defaultImage: UIImage(named: "login_bg"))
            cell.avtarImg.setImageWithURL(makeImageURL(message.avatar), defaultImage: UIImage(named: "login_bg"))
            cell.titleLabel.text = message.name
            return cell
        } else {
            let message = delegate.showInfoWithTop(indexPath.row)
            cell.hasCor = false
            cell.headImg.setImageWithURL(makeImageURL(message.headimg), defaultImage: UIImage(named: "login_bg"))
            cell.avtarImg.setImageWithURL(makeImageURL(message.avatar), defaultImage: UIImage(named: "login_bg"))
            cell.titleLabel.text = message.name
            return cell
        }
    }
    
}
