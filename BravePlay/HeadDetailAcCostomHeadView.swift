//
//  HeadDetailAcCostomHeadView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/3.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit


class HeadDetailAcCostomHeadView : UIView {
    
    var bgImageArray: [String] = []
    private let cellIdentifier: String = "CustomCellCollectionViewCell"
    private var customView: HeadDetailAcCustomView!
    private var collectionView : UICollectionView?
    private let pageControl: UIPageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        let collectionViewFlowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .Horizontal
        collectionViewFlowLayout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        collectionViewFlowLayout.minimumInteritemSpacing = 1
        collectionViewFlowLayout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewFlowLayout)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        addSubview(collectionView!)
        customView = HeadDetailAcCustomView(frame: CGRect(x: 0, y: bounds.height / 3 * 2, width: bounds.width, height: bounds.height / 3))
        addSubview(customView)
        
        pageControl.numberOfPages = bgImageArray.count
        pageControl.frame.size = CGSize(width: 40, height: 20)
        pageControl.frame.origin = CGPoint(x: center.x - pageControl.bounds.width / 2, y: 44)
        pageControl.pageIndicatorTintColor = UIColor ( red: 0.4863, green: 0.4745, blue: 0.4627, alpha: 1.0 )
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        addSubview(pageControl)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if bgImageArray.count == 0 {
            return
        }
        
        if scrollView.contentOffset.x > CGFloat(bgImageArray.count - 1) * bounds.width {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: true)
            pageControl.currentPage = 0
            return
        } else if scrollView.contentOffset.x < 0 {
            let indexPath = NSIndexPath(forRow: bgImageArray.count - 1, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: true)
            pageControl.currentPage = bgImageArray.count - 1
            return
        }
        let curIndex = scrollView.contentOffset.x / bounds.width
        pageControl.currentPage = Int(curIndex)
    }
    

    
    @objc private func startScroll() {
        if pageControl.currentPage == bgImageArray.count - 1 {
            pageControl.currentPage = 0
            let indexPath = NSIndexPath(forRow: pageControl.currentPage, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: true)
        } else if pageControl.currentPage >= 0 {
            pageControl.currentPage += 1
            let indexPath = NSIndexPath(forRow: pageControl.currentPage, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: true)
        }
    }
    
    func reloadData(imageUrl: String, name: String, info: String) {
        pageControl.numberOfPages = bgImageArray.count
        collectionView?.reloadData()
        
        customView.circleImageView.setImageWithURL(makeImageURL(imageUrl), defaultImage: UIImage(named: "find_mw_bg"))
        customView.authorLabel.text = "by  " + name
        customView.activityInfo.text = info
        
        let nsTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(startScroll), userInfo: nil, repeats: true)
        nsTimer.fire()
    }
    
}

extension HeadDetailAcCostomHeadView :  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bgImageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? CustomCellCollectionViewCell else {
            return UICollectionViewCell()
        }
//        cell.customHeadImage.image = UIImage(named: "find_mw_bg")
        cell.customHeadImage.setImageWithURL(makeImageURL(bgImageArray[indexPath.row]), defaultImage: UIImage(named: "find_mw_bg"))
        return cell
    }
    
}