//
//  MineSectionViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit
import Result

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
    
    private var newWindow: UIWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height))
    private var beforeKeyWindow: UIWindow = UIWindow()
    
    //未读消息
    private var unreadCount : UnReadCount = UnReadCount()
    //系统消息
    private var systemMessage: [UserMessage] = []
    //关注列表
    private var careList: UserCareList  = UserCareList()
    //喜欢列表
    private var likeList: [UserLike] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.2353, green: 0.3333, blue: 0.3451, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false

        if let window = UIApplication.sharedApplication().keyWindow {
             beforeKeyWindow = window
        }
        
        newWindow.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        newWindow.frame.origin = CGPoint(x: 0.0, y: 0.0)
        let scale = CGAffineTransformMakeScale(0.0001, 0.0001)
        newWindow.transform = scale
        
        addHeadView()
        addTypeView()
        initCollectionView()
        
        let tapWindow = UITapGestureRecognizer(target: self, action: #selector(MineSectionViewController.tapWindowAction))
        newWindow.addGestureRecognizer(tapWindow)
    }
    
    @objc private func tapWindowAction () {
        UIView.animateWithDuration(0.5, animations: { [unowned self] _ in
            self.newWindow.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            let scale = CGAffineTransformMakeScale(0.0001, 0.0001)
            self.newWindow.transform = scale
            let beforeTransform = CGAffineTransformScale(self.beforeKeyWindow.transform, 1.0 / 0.9, 1.0 / 0.9)
            self.beforeKeyWindow.transform = beforeTransform
            }, completion: { [unowned self] _ in
                self.newWindow.resignKeyWindow()
                self.beforeKeyWindow.makeKeyAndVisible()
                self.newWindow.subviews.forEach({
                    $0.removeFromSuperview()
                })
        })
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
        
        if let loged = UserData.UserDatas.isLoged {
            if loged {
//                //未读消息
//                requestData(UserData.UserDatas.access_token!)
//                //系统消息
//                systemMessage(1)
//                //关注列表
//                requestCareList()
                //喜欢列表
                requestLikeList(1)
                headView.nick = UserData.UserDatas.nickName!
            } else {
                headView.nick = "未登录"
            }
        } else {
            headView.nick = "未登录"
        }
        
        if let headImageUrl = UserData.UserDatas.avatar {
            headView.headImageViewUrl = headImageUrl
        }
        
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

        headView.tapImageAction = { [unowned self] _ in
            UIView.animateWithDuration(0.5, animations: {
                let newTransform = CGAffineTransformScale(self.beforeKeyWindow.transform, 0.9, 0.9)
                self.beforeKeyWindow.transform = newTransform
                self.beforeKeyWindow.resignKeyWindow()
                self.newWindow.becomeFirstResponder()
                self.newWindow.makeKeyAndVisible()
                self.presentView(UserData.UserDatas.avatar)
            })
        }
        
        headView.tapNickButotnAction = { [unowned self] _ in
            if let loged = UserData.UserDatas.isLoged {
                if !loged {
                    gotoLogIn(self)
                }
            }
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
        let height = view.bounds.size.height - headView.bounds.size.height - 50 - 44
        collectionViewLayout.itemSize = CGSize(width: view.bounds.size.width, height: height - 15)
        
        collectionView = UICollectionView(frame: CGRect(x: 0,y: 150,width: view.bounds.size.width, height: height), collectionViewLayout: collectionViewLayout)
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
    
    func presentView(imageUrl: String?) {
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height / 2
        let imageView = UIImageView(frame: CGRect(x: 0, y: height / 2, width: width, height: height))
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFill
        
        if imageUrl == nil {
            imageView.image = UIImage(named: "find_mw_bg")
        } else {
            imageView.setImageWithURL(makeImageURL(imageUrl!), defaultImage: UIImage(named: "find_mw_bg"))
        }
        newWindow.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        let scale = CGAffineTransformMakeScale(1, 1)
        newWindow.transform = scale
        newWindow.backgroundColor = UIColor.clearColor()
        newWindow.addSubview(imageView)
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
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(likeCellIdentifier, forIndexPath: indexPath) as? MineLikeCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ticketInfoCellIdentifier, forIndexPath: indexPath) as? MineTicketInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
}

// 请求数据
extension MineSectionViewController : MoyaPares {
    
    //未读消息
    private func requestData(userToken: String) {
        mineSectionProvider.request(MineSection.UnReadCount(userToken: userToken), completion: { [unowned self] result in
            let resultData : Result<UnReadCount, MyErrorType> = self.paresObject(result)
            
            switch resultData {
            case .Success(let data):
                self.unreadCount.unread_notification_count = data.unread_notification_count
                print("\(#function) :: \(data.unread_notification_count)")
            case .Failure(let error):
                self.dealWithError(error)
            }
        })
    }
    
    //系统消息
    private func systemMessage(page: Int) {
        mineSectionProvider.request(MineSection.SystemMessage(page: page), completion: { [unowned self] result in
            let resultData : Result<[UserMessage], MyErrorType> = self.paresObjectArray(result)
            
            switch resultData {
            case .Success(let data):
                self.systemMessage = data
                print("\(#function) :: \(data)")
            case .Failure(let error):
                self.dealWithError(error)
            }
            })
    }
    //关注列表
    private func requestCareList() {
        mineSectionProvider.request(MineSection.CareList, completion: { [unowned self] result in
            let resultData : Result<UserCareList, MyErrorType> = self.paresObject(result)
            
            switch resultData {
            case .Success(let data):
                self.careList = data
                print("\(#function) :: \(data)")
            case .Failure(let error):
                self.dealWithError(error)
            }
            })
    }
    //喜欢列表
    private func requestLikeList(page: Int) {
        mineSectionProvider.request(MineSection.LikeList(page: page), completion: { [unowned self] result in
            let resultData : Result<[UserLike], MyErrorType> = self.paresObjectArray(result)
            
            switch resultData {
            case .Success(let data):
                self.likeList = data
                print("\(self.likeList[0].topic)")
                print("\(self.likeList[0].video)")
            case .Failure(let error):
                self.dealWithError(error)
            }
            })
    }
}