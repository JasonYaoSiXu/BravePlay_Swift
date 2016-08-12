//
//  CusTomHeadView.swift
//  BravePlay
//
//  Created by yaosixu on 16/7/29.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol CustomHeadViewDelegate :class {
    func pushToHeadDetailVC(indexPath: (String,String,String))
    func showInfoWith(indexPath: Int) -> BannerItem
}

// 自定义headView
class CustomHeadView : UIView {
    
    private let pageControl  = UIPageControl()
    private let cellIdentifier = "CustomCellCollectionViewCell"
    private var contentOffSetX : CGFloat = 0
    private var  collectionView : UICollectionView!
    private var  nsTimer = NSTimer()
    private var time = 0
    weak var delegate: CustomHeadViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.scrollDirection = .Horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.description
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.backgroundColor = UIColor.clearColor()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        addSubview(collectionView)
    }
    
    private func setUI() {
        pageControl.numberOfPages = 5
        pageControl.frame = CGRect(x: self.frame.size.width - 85, y: self.frame.size.height - 20, width: 70, height: 10)
        pageControl.backgroundColor = UIColor.clearColor()
        pageControl.pageIndicatorTintColor = UIColor ( red: 0.4863, green: 0.4745, blue: 0.4627, alpha: 1.0 )
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        
        addSubview(pageControl)
    }
    
    func reloadData() {
        setCollectionView()
        setUI()
        nsTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(startScroll), userInfo: nil, repeats: true)
        nsTimer.fire()
    }
    
    @objc private func startScroll() {
        if time == 0 {
            time += 1
            return
        }
        
        if pageControl.currentPage == 4 {
            pageControl.currentPage = 0
            let indexPath = NSIndexPath(forRow: pageControl.currentPage, inSection: 0)
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: true)
        } else if pageControl.currentPage >= 0 {
            pageControl.currentPage += 1
            let indexPath = NSIndexPath(forRow: pageControl.currentPage, inSection: 0)
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: true)
        }
        
    }
    
}

extension CustomHeadView : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? CustomCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        let info = delegate.showInfoWith(indexPath.row)
        cell.action = { _ in
            return (info.type,info.dist_id,info.description)
        }
        cell.customHeadImage.setImageWithURL(makeImageURL(info.img_mobile_url), defaultImage: UIImage(named: "login_bg"))
        cell.titleLabel.hidden = false
        cell.titleLabel.text = info.description
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 1 "活动" 2 “TV”
        
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CustomCellCollectionViewCell else {
            return
        }
        
        if let action = cell.action {
                delegate.pushToHeadDetailVC(action())
        }
    }
    
}

//轮播
extension CustomHeadView {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > CGFloat(4) * bounds.width {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: true)
            pageControl.currentPage = 0
            return
        } else if scrollView.contentOffset.x < 0 {
            let indexPath = NSIndexPath(forRow: 4, inSection: 0)
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: true)
            pageControl.currentPage = 4
            return
        }
        let curIndex = scrollView.contentOffset.x / bounds.width
        pageControl.currentPage = Int(curIndex)
    }
    
}


