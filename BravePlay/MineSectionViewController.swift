//
//  MineSectionViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

class MineSectionViewController: UIViewController {
    private let subviewsWidth: CGFloat = (UIScreen.mainScreen().bounds.size.width - 40) / 4
    private let ticketInfoCellIdentifier: String = "MineTicketInfoCollectionViewCell"
    private let careCellIdentifier: String = "MineCareCollectionViewCell"
    private let likeCellIdentifier: String = "MineLikeCollectionViewCell"
    private var isTapTypeButton : Bool = true
    private var currentScrollerLineOriginX: CGFloat = 10
    private var afterCollectionViewOffset: CGFloat = 0
    
    private var collectionView : UICollectionView!
    private let headView = MineSectionHeadView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 90))
    private let typeView: UIView = UIView()
    private let ticketButton: UIButton = UIButton()
    private let careButton: UIButton = UIButton()
    private let likeButton: UIButton = UIButton()
    private let infoButton: UIButton = UIButton()
    private let spaceLine: UIView = UIView()
    private let scrollLine: UIView = UIView()
    private var typeButtonArray: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        
        addHeadView()
        addTypeView()
        initCollectionView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        navigationController?.navigationBar.alpha = 1.0
        
        navigationController?.navigationBar.barTintColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addHeadView() {
        view.addSubview(headView)
        headView.tapSetButtonAction = { [unowned self] _ in
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(MineSetViewController(), animated: true)
            self.hidesBottomBarWhenPushed = false
        }

        headView.tapImageAction = { _ in
            
        }
        
    }
    
    private func addTypeView() {
        typeView.backgroundColor = headView.backgroundColor
        view.addSubview(typeView)
        typeView.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(self.headView.snp.bottom).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(50)
        })
        
        typeView.addSubview(spaceLine)
        spaceLine.backgroundColor = UIColor ( red: 0.5961, green: 0.5843, blue: 0.7725, alpha: 1.0 )
        spaceLine.snp.makeConstraints(closure: { make in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
        })
        
        typeView.addSubview(scrollLine)
        scrollLine.backgroundColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        scrollLine.snp.makeConstraints(closure: { make in
            make.left.equalTo(20)
            make.bottom.equalTo(-2)
            make.height.equalTo(2)
            make.width.equalTo(subviewsWidth)
        })
        
        addSubviewsToTypeView()
    }
    
    private func addSubviewsToTypeView() {
        typeView.addSubview(ticketButton)
        ticketButton.setTitle("票务", forState: .Normal)
        ticketButton.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
        ticketButton.backgroundColor = UIColor.clearColor()
        ticketButton.tag = 0
        ticketButton.addTarget(self, action: #selector(MineSectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        ticketButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(20)
            make.width.equalTo(self.subviewsWidth)
            make.centerY.equalTo(self.typeView.snp.centerY)
        })
        typeButtonArray.append(ticketButton)
        
        typeView.addSubview(careButton)
        careButton.setTitle("关注", forState: .Normal)
        careButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        careButton.backgroundColor = UIColor.clearColor()
        careButton.tag = 1
        careButton.addTarget(self, action: #selector(MineSectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        careButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(self.ticketButton.snp.right).offset(0)
            make.width.equalTo(self.subviewsWidth)
            make.centerY.equalTo(self.typeView.snp.centerY)
            })
        typeButtonArray.append(careButton)
        
        typeView.addSubview(likeButton)
        likeButton.setTitle("喜欢", forState: .Normal)
        likeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        likeButton.backgroundColor = UIColor.clearColor()
        likeButton.tag = 2
        likeButton.addTarget(self, action: #selector(MineSectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        likeButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(self.careButton.snp.right).offset(0)
            make.width.equalTo(self.subviewsWidth)
            make.centerY.equalTo(self.typeView.snp.centerY)
            })
        typeButtonArray.append(likeButton)

        typeView.addSubview(infoButton)
        infoButton.setTitle("消息", forState: .Normal)
        infoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        infoButton.backgroundColor = UIColor.clearColor()
        infoButton.tag = 3
        infoButton.addTarget(self, action: #selector(MineSectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        infoButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(self.likeButton.snp.right).offset(0)
            make.right.equalTo(-20)
            make.centerY.equalTo(self.typeView.snp.centerY)
            })
        typeButtonArray.append(infoButton)
    }
    
    @objc private func tapTypeButton(button: UIButton) {
        print("MineSectionViewController:: [\(#function)] tapButton Tag = \(button.tag)")
        typeButtonArray.forEach({
            if $0 != button {
                $0.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        })
        isTapTypeButton = false
        let index = NSIndexPath(forRow: button.tag, inSection: 0)
        UIView.animateWithDuration(0.25, animations: { [unowned self]  _ in
            button.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
            self.scrollLine.frame.origin.x = button.frame.origin.x
            self.collectionView.scrollToItemAtIndexPath(index, atScrollPosition: .Left, animated: true)
        })
    }
    
    private func initCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .Horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        let height = view.bounds.size.height - headView.bounds.size.height - 50
        collectionViewLayout.itemSize = CGSize(width: view.bounds.size.width, height: height)
        
        collectionView = UICollectionView(frame: CGRect(x: 0,y: view.bounds.size.height - height,width: view.bounds.size.width, height: height), collectionViewLayout: collectionViewLayout)
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor ( red: 0.2353, green: 0.3333, blue: 0.3451, alpha: 1.0 )
        
        var nib = UINib(nibName: ticketInfoCellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: ticketInfoCellIdentifier)
        nib = UINib(nibName: careCellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: careCellIdentifier)
        nib = UINib(nibName: likeCellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: likeCellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        isTapTypeButton = true
        currentScrollerLineOriginX = scrollLine.frame.origin.x
        afterCollectionViewOffset = collectionView.contentOffset.x
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isTapTypeButton == false {
            return
        }
        
        if Int(collectionView.contentOffset.x) > 0 || collectionView.contentOffset.x < UIScreen.mainScreen().bounds.size.width - 20 {
            var progress = ((collectionView.contentOffset.x % UIScreen.mainScreen().bounds.size.width)  / (UIScreen.mainScreen().bounds.size.width - 1))
            print("\(#function):: \(progress)")
            
            if afterCollectionViewOffset > collectionView.contentOffset.x {
                progress = -progress + 1
                scrollLine.frame.origin.x = currentScrollerLineOriginX + (subviewsWidth) * (-progress)
            } else {
                if progress >= 0.95 || progress == 0 {
                    progress = 1.0
                } else if progress < 0 {
                    progress = 0.0
                }
                scrollLine.frame.origin.x = currentScrollerLineOriginX + (subviewsWidth) * progress
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let buttonIndex = Int(collectionView.contentOffset.x / UIScreen.mainScreen().bounds.size.width)
        for i in 0..<typeButtonArray.count {
            if i == buttonIndex {
                UIView.animateWithDuration(0.10, animations: { [unowned self] _ in
                    self.typeButtonArray[i].setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
                    self.scrollLine.frame.origin.x = self.typeButtonArray[i].frame.origin.x
                    })
            } else {
                typeButtonArray[i].setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
        currentScrollerLineOriginX = scrollLine.frame.origin.x
        afterCollectionViewOffset = collectionView.contentOffset.x
    }
    
}

extension MineSectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ticketInfoCellIdentifier, forIndexPath: indexPath) as? MineTicketInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(careCellIdentifier, forIndexPath: indexPath) as? MineCareCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = UIColor.cyanColor()
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(likeCellIdentifier, forIndexPath: indexPath) as? MineLikeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = UIColor.brownColor()
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ticketInfoCellIdentifier, forIndexPath: indexPath) as? MineTicketInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
}

