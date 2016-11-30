//
//  ActivitySectionViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

// 13 0 12 5 14 

import UIKit
import Result

// 全部 filter = 0 热门 filter = 12 免费 filter = 14 室内 filter = 5 课程 filter = 13

enum ActivityType: Int {
    case All = 0
    case Hot = 12
    case Free = 14
    case Room = 5
    case Course = 13
}


class ActivitySectionViewController: UIViewController {

    private var city: String = "全国"
    private let cellIdentifier: String = "ActivitySectionCollectionViewCell"
    private let controWidth: CGFloat = (UIScreen.mainScreen().bounds.size.width - 20) / 5
    
    private var allActivity: AllActivity? = AllActivity()
    private var hotActivity: HotActivity? = HotActivity()
    private var freeActivity: FreeActivity? = FreeActivity()
    private var roomActivity: RoomActivity? = RoomActivity()
    private var courseActivity: CourseActivity? = CourseActivity()
    
    private let typeView = UIView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.size.width, height: 50))
    private var spaceLine = UIView()
    private var scrollerLine = UIView()
    private let allButton = UIButton()
    private let hotButton = UIButton()
    private let freeButton = UIButton()
    private let roomButton = UIButton()
    private let courseButton = UIButton()
    private var typeButtonArray: [UIButton] = []
    
    private var isTapTypeButton : Bool = true
    private var currentScrollerLineOriginX: CGFloat = 10
    private var afterCollectionViewOffset: CGFloat = 0
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        
        chooseTypeHeadView()
        setNavigationBar()
        initCollectionView()
        requestAll(1, filter: ActivityType.All.rawValue, location: city)
        // Do any additional setup after loading the view.
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 1.0
        
        navigationController?.navigationBar.barTintColor = UIColor( red: 0.0824, green: 0.1216, blue: 0.1412, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "活动列表"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let leftButton = UIBarButtonItem(title: "全国", style: .Done, target: self, action: #selector(ActivitySectionViewController.chooseCity))
        leftButton.title = city
        navigationItem.leftBarButtonItem = leftButton
    }

    @objc private func chooseCity() {
        let cityVc = ActivityChooseCityViewController(chooseCity: city)
        cityVc.delegate = self
        presentViewController(cityVc, animated: true, completion: nil)
    }
    
    private func chooseTypeHeadView() {
        
        typeView.backgroundColor = UIColor ( red: 0.1294, green: 0.2, blue: 0.2275, alpha: 1.0 )
        
        typeView.addSubview(spaceLine)
        spaceLine.backgroundColor = UIColor ( red: 0.5961, green: 0.5843, blue: 0.7725, alpha: 1.0 )
        spaceLine.snp.makeConstraints(closure: { make in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
        })
        
        typeView.addSubview(scrollerLine)
        scrollerLine.backgroundColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        scrollerLine.snp.makeConstraints(closure: { make in
            make.left.equalTo(10)
            make.width.equalTo(controWidth)
            make.height.equalTo(2)
            make.bottom.equalTo(-2)
        })
        
        view.addSubview(typeView)
        addTypeButton()
    }
    
    private func addTypeButton() {
        typeView.addSubview(allButton)
        allButton.setTitle("全部", forState: .Normal)
        allButton.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
        allButton.tag = 0
        allButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(10)
            make.centerY.equalTo(self.typeView.snp.centerY)
            make.width.equalTo(self.controWidth)
        })
        allButton.addTarget(self, action: #selector(ActivitySectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        typeButtonArray.append(allButton)
        
        typeView.addSubview(hotButton)
        hotButton.setTitle("热门", forState: .Normal)
        hotButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        hotButton.tag = 1
        hotButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(self.allButton.snp.right).offset(0)
            make.centerY.equalTo(self.typeView.snp.centerY)
            make.width.equalTo(self.controWidth)
            })
        hotButton.addTarget(self, action: #selector(ActivitySectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        typeButtonArray.append(hotButton)
        
        typeView.addSubview(freeButton)
        freeButton.setTitle("免费", forState: .Normal)
        freeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        freeButton.tag = 2
        freeButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(self.hotButton.snp.right).offset(0)
            make.centerY.equalTo(self.typeView.snp.centerY)
            make.width.equalTo(self.controWidth)
            })
        freeButton.addTarget(self, action: #selector(ActivitySectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        typeButtonArray.append(freeButton)
        
        typeView.addSubview(roomButton)
        roomButton.setTitle("室内", forState: .Normal)
        roomButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        roomButton.tag = 3
        roomButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(self.freeButton.snp.right).offset(0)
            make.centerY.equalTo(self.typeView.snp.centerY)
            make.width.equalTo(self.controWidth)
            })
        roomButton.addTarget(self, action: #selector(ActivitySectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        typeButtonArray.append(roomButton)
        
        typeView.addSubview(courseButton)
        courseButton.setTitle("课程", forState: .Normal)
        courseButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        courseButton.tag = 4
        courseButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(self.roomButton.snp.right).offset(0)
            make.right.equalTo(-10)
            make.centerY.equalTo(self.typeView.snp.centerY)
            })
        courseButton.addTarget(self, action: #selector(ActivitySectionViewController.tapTypeButton(_:)), forControlEvents: .TouchUpInside)
        typeButtonArray.append(courseButton)
    }
    
    @objc private func tapTypeButton(button: UIButton) {
        print("\(#function) :: button.tag = \(button.tag)")
        
        typeButtonArray.forEach({
            if $0 != button {
                $0.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        })
        
        let index = NSIndexPath(forRow: button.tag, inSection: 0)
        
        isTapTypeButton = false
        
        UIView.animateWithDuration(0.25, animations: { [unowned self] _ in
            button.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
            self.scrollerLine.frame.origin.x = button.frame.origin.x
            self.collectionView.scrollToItemAtIndexPath(index, atScrollPosition: .Left, animated: true)
            })
    }
    
    private func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height - 170)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 124,width: view.bounds.size.width, height: view.bounds.size.height - 170), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        afterCollectionViewOffset = collectionView.contentOffset.x
        
        view.addSubview(collectionView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        isTapTypeButton = true
        currentScrollerLineOriginX = scrollerLine.frame.origin.x
        afterCollectionViewOffset = collectionView.contentOffset.x
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isTapTypeButton == false {
            return
        }
        
        if Int(collectionView.contentOffset.x) > 0 || collectionView.contentOffset.x < UIScreen.mainScreen().bounds.size.width - 10 {
            var progress = ((collectionView.contentOffset.x % UIScreen.mainScreen().bounds.size.width)  / (UIScreen.mainScreen().bounds.size.width - 1))
            print("\(#function):: \(progress)")

            if afterCollectionViewOffset > collectionView.contentOffset.x {
                progress = -progress + 1
                scrollerLine.frame.origin.x = currentScrollerLineOriginX + (controWidth) * (-progress)
            } else {
                if progress >= 0.95 || progress == 0 {
                    progress = 1.0
                } else if progress < 0 {
                    progress = 0.0
                }
                scrollerLine.frame.origin.x = currentScrollerLineOriginX + (controWidth) * progress
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let buttonIndex = Int(collectionView.contentOffset.x / UIScreen.mainScreen().bounds.size.width)
        for i in 0..<typeButtonArray.count {
            if i == buttonIndex {
                UIView.animateWithDuration(0.10, animations: { [unowned self] _ in
                    self.typeButtonArray[i].setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
                    self.scrollerLine.frame.origin.x = self.typeButtonArray[i].frame.origin.x
                })
            } else {
                typeButtonArray[i].setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
        currentScrollerLineOriginX = scrollerLine.frame.origin.x
        afterCollectionViewOffset = collectionView.contentOffset.x
    }
    
}

extension ActivitySectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? ActivitySectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.takeData = { [unowned self] _ in
                return (self.allActivity,nil,nil,nil,nil)
            }
        case 1:
            cell.takeData = { [unowned self] _ in
                return (nil,self.hotActivity,nil,nil,nil)
            }
        case 2:
            cell.takeData = { [unowned self] _ in
                return (nil,nil,self.freeActivity,nil,nil)
            }
        case 3:
            cell.takeData = { [unowned self] _ in
                return (nil,nil,nil,self.roomActivity,nil)
            }
        case 4:
            cell.takeData = { [unowned self] _ in
                return (nil,nil,nil,nil,self.courseActivity)
            }
        default:
            return cell
        }
        cell.delegate = self
        cell.customTableView.reloadData()
        
        return cell
    }
    
}

extension ActivitySectionViewController : ActivityChooseCityViewControllerDelegate, ActivitySectionCollectionViewCellDelegate {
    
    func takeChooseCity(chooseCity: String) {
        city = chooseCity
        requestAll(1, filter: ActivityType.All.rawValue, location: city)
    }
    
    func tapTableViewCell(rankList: RankList) {
        let activityVc = HeadViewDetailViewController(showId: rankList.id, vcTitle: rankList.title)
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(activityVc, animated: true)
        hidesBottomBarWhenPushed = false
    }
    
}


//网络请求
extension ActivitySectionViewController : MoyaPares {
    
    //全部活动
    private func requestAll(page: Int,filter: Int,location: String) {
        var newLoaction = ""
        if location == "全国" {
            newLoaction = ""
        } else {
            newLoaction = location
        }
        self.showHud("正在加载")
        ActivitySectionProvider.request(ActivitySection.ActivityList(page: page, filter: filter, location: newLoaction), completion: { [unowned self] result in
            let resultData : Result<AllActivity,MyErrorType> = self.paresObject(result)
            switch resultData {
            case .Success(let data):
                self.allActivity = data
                self.requestHot(1, filter: ActivityType.Hot.rawValue, location: location)
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        })
    }
    
    //热门活动
    private func requestHot(page: Int,filter: Int,location: String) {
        var newLoaction = ""
        if location == "全国" {
            newLoaction = ""
        } else {
            newLoaction = location
        }
        
        ActivitySectionProvider.request(ActivitySection.ActivityList(page: page, filter: filter, location: newLoaction), completion: { [unowned self] result in
            let resultData : Result<HotActivity,MyErrorType> = self.paresObject(result)
            switch resultData {
            case .Success(let data):
                self.hotActivity = data
                self.requestFree(1, filter: ActivityType.Free.rawValue, location: location)
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
            })
    }
    
    //免费活动
    private func requestFree(page: Int,filter: Int,location: String) {
        var newLoaction = ""
        if location == "全国" {
            newLoaction = ""
        } else {
            newLoaction = location
        }
        
        ActivitySectionProvider.request(ActivitySection.ActivityList(page: page, filter: filter, location: newLoaction), completion: { [unowned self] result in
            let resultData : Result<FreeActivity,MyErrorType> = self.paresObject(result)
            switch resultData {
            case .Success(let data):
                self.freeActivity = data
                self.requestRoom(1, filter: ActivityType.Room.rawValue, location: location)
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
            })
    }

    //室内活动
    private func requestRoom(page: Int,filter: Int,location: String) {
        var newLoaction = ""
        if location == "全国" {
            newLoaction = ""
        } else {
            newLoaction = location
        }
        
        ActivitySectionProvider.request(ActivitySection.ActivityList(page: page, filter: filter, location: newLoaction), completion: { [unowned self] result in
            let resultData : Result<RoomActivity,MyErrorType> = self.paresObject(result)
            switch resultData {
            case .Success(let data):
                self.roomActivity = data
                self.requestCourse(1, filter: ActivityType.Course.rawValue, location: location)
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
            })
    }
    
    //课程活动
    private func requestCourse(page: Int,filter: Int,location: String) {
        var newLoaction = ""
        if location == "全国" {
            newLoaction = ""
        } else {
            newLoaction = location
        }
        
        ActivitySectionProvider.request(ActivitySection.ActivityList(page: page, filter: filter, location: newLoaction), completion: { [unowned self] result in
            let resultData : Result<CourseActivity,MyErrorType> = self.paresObject(result)
            switch resultData {
            case .Success(let data):
                self.popHud()
                self.courseActivity = data
                self.collectionView.reloadData()
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
            })
    }
    
}