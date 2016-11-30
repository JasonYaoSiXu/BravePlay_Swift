//
//  CirclePlay.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/25.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol  HeadViewDelegate : class {
    func pushToHeadDetailVC(indexPath: (String,String,String))
}

enum PageControlLocation {
    case TopLeft
    case TopRight
    case BottomLeft
    case BottomRight
}

class HeadView : UIView {
    
    private var collectionView : UICollectionView!
    private let cellIdentifier : String = "CustomCellCollectionViewCell"
    private let pageControl = UIPageControl()
    private var nstime = NSTimer()
    private var isAutoScrollToLast = false
    private var bannerItem: [BannerItem] = []
    weak var delegate : HeadViewDelegate!
    
    ///是否定时轮播，默认为true
    var isCircle = false {
        didSet {
            if isCircle == false {
                nstime.invalidate()
            }
        }
    }
    
    ///当前pageControl的颜色
    var currentPageColor = UIColor.redColor() {
        didSet {
            pageControl.currentPageIndicatorTintColor = currentPageColor
        }
    }
    
    ///没有被选中的pageControlPage的颜色
    var notCurrenPageColor = UIColor.cyanColor() {
        didSet {
            pageControl.pageIndicatorTintColor = notCurrenPageColor
        }
    }
    
    ///pageControlr中心点的位置
    var centerOfPageControl : CGPoint = CGPointZero {
        didSet {
            pageControl.center = centerOfPageControl
        }
    }
    
    ///获取pageControl的大小
    var pageControlSize : CGSize {
        get {
            return pageControl.frame.size
        }
    }
    
    init(frame: CGRect,bannerItem: [BannerItem]) {
        super.init(frame: frame)
        
        self.bannerItem = bannerItem
        if bannerItem.count > 1 {
            self.bannerItem.insert(bannerItem.last!, atIndex: 0)
            self.bannerItem.insert(bannerItem.first!, atIndex: self.bannerItem.count)
        }
        
        initCollectionView()
        pageControl.numberOfPages = bannerItem.count
        pageControl.frame = CGRect(x: 20, y: 10, width: 100, height: 20)
        addSubview(pageControl)
        pageControl.pageIndicatorTintColor = UIColor.cyanColor()
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.currentPage = 0
        startTime()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCollectionView() {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: bounds.size.width, height: bounds.size.height)
        collectionViewLayout.scrollDirection = .Horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        if bannerItem.count > 1 {
            collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 1,inSection: 0), atScrollPosition: .Left, animated: false)
        }
        addSubview(collectionView)
    }
    
    ///设置pageControl在那个方位 左上角、右上角、左下角、右下角.
    func locationOfPageControl(location: PageControlLocation) {
        let width : CGFloat = bounds.size.width
        let height : CGFloat = bounds.size.height
        let pageControlWidth : CGFloat = pageControl.frame.size.width
        let pageControlHeight : CGFloat = pageControl.frame.size.height
        
        switch location {
        case .TopLeft:
            pageControl.frame.origin = CGPoint(x: 0, y: 0)
        case .TopRight:
            pageControl.frame.origin = CGPoint(x: width - pageControlWidth, y: 0)
        case .BottomLeft:
            pageControl.frame.origin = CGPoint(x: 0, y: height - pageControlHeight)
        case .BottomRight:
            pageControl.frame.origin = CGPoint(x: width - pageControlWidth, y: height - pageControlHeight)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        nstime.invalidate()
        if scrollView.contentOffset.x == 0 {
            collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: bannerItem.count - 2,inSection: 0), atScrollPosition: .Left, animated: false)
            pageControl.currentPage = bannerItem.count - 3
        } else if scrollView.contentOffset.x == CGFloat(bannerItem.count - 1) * bounds.size.width {
            collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 1,inSection: 0), atScrollPosition: .Left, animated: false)
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage = Int(scrollView.contentOffset.x / bounds.size.width - 1)
        }
        startTime()
    }
    
    func startTime() {
        nstime = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        if pageControl.currentPage == bannerItem.count - 3 {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: self.pageControl.currentPage + 2,inSection: 0), atScrollPosition: .Left, animated: true)
            self.pageControl.currentPage = 0
            self.isAutoScrollToLast = true
        } else {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: self.pageControl.currentPage + 2,inSection: 0), atScrollPosition: .Left, animated: true)
            self.pageControl.currentPage += 1
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if isAutoScrollToLast {
            collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 1,inSection: 0), atScrollPosition: .Right, animated: false)
            isAutoScrollToLast = !isAutoScrollToLast
        }
    }
    
}

extension HeadView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerItem.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? CustomCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.customHeadImage.setImageWithURL(makeImageURL(bannerItem[indexPath.row].img_mobile_url), defaultImage: UIImage(named: "find_mw_bg"))
        cell.titleLabel.hidden = false
        cell.titleLabel.text = bannerItem[indexPath.row].description
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 0 类型 1 活动id 2 活动名称
        if delegate == nil {
            return
        }
        
        delegate.pushToHeadDetailVC((bannerItem[indexPath.row].type,bannerItem[indexPath.row].dist_id,bannerItem[indexPath.row].description))
    }
    
}
