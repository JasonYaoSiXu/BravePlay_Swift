//
//  UserVcRecommendTableViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/15.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol  UserVcRecommendTableViewCellDelegate : class {
    func tapCollectionView(index: Int)
}

class UserVcRecommendTableViewCell: UITableViewCell {

    var takeData: ((Void) -> [UserRecommendResponse])?
    var customCollectionView: UICollectionView!
    let collectionViewCell = "UserVcRecommendCollectionViewCell"
    weak var delegate: UserVcRecommendTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        initCollectionView()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initCollectionView() {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .Horizontal
        collectionViewLayout.itemSize = CGSize(width: 70, height: 100)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        
        customCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: bounds.size.height), collectionViewLayout: collectionViewLayout)
        addSubview(customCollectionView)
        customCollectionView.backgroundColor = UIColor.clearColor()
        customCollectionView.showsHorizontalScrollIndicator = false
        let nib = UINib(nibName: collectionViewCell, bundle: nil)
        customCollectionView.registerNib(nib, forCellWithReuseIdentifier: collectionViewCell)
        customCollectionView.dataSource = self
        customCollectionView.delegate = self
    }
    
}

extension UserVcRecommendTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if takeData == nil {
            return 1
        }
        return takeData!().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCell, forIndexPath: indexPath) as? UserVcRecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let data = takeData?() else {
            return cell
        }
        
        cell.recommendImageView.setImageWithURL(makeImageURL(data[indexPath.row].avatar), defaultImage: UIImage(named: "find_mw_bg"))
        cell.recommendLabel.text = data[indexPath.row].name
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate.tapCollectionView(indexPath.row)
    }
    
}
