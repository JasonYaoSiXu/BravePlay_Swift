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

    private var city: String = "上海"
    private let cellIdentifier: String = "ActivitySectionCollectionViewCell"
    
    private var allActivity: AllActivity? = AllActivity()
    private var hotActivity: HotActivity? = HotActivity()
    private var freeActivity: FreeActivity? = FreeActivity()
    private var roomActivity: RoomActivity? = RoomActivity()
    private var courseActivity: CourseActivity? = CourseActivity()
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        
        setNavigationBar()
        initCollectionView()
        requestData()
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
    
    private func requestData() {
        //全部活动
        requestAll(1, filter: ActivityType.All.rawValue, location: city)
        //热门活动
        requestHot(1, filter: ActivityType.Hot.rawValue, location: city)
        //免费活动
        requestFree(1, filter: ActivityType.Free.rawValue, location: city)
        //室内活动
        requestRoom(1, filter: ActivityType.Room.rawValue, location: city)
        //课程活动
        requestCourse(1, filter: ActivityType.Course.rawValue, location: city)
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
    
    private func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height - 110)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 64,width: view.bounds.size.width, height: view.bounds.size.height - 110), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.pagingEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        
        view.addSubview(collectionView)
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
        
        cell.customTableView.reloadData()
        
        return cell
    }
    
}

extension ActivitySectionViewController : ActivityChooseCityViewControllerDelegate {
    
    func takeChooseCity(chooseCity: String) {
        city = chooseCity
        print("\(#function):: city = \(chooseCity)")
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
        
        ActivitySectionProvider.request(ActivitySection.ActivityList(page: page, filter: filter, location: newLoaction), completion: { [unowned self] result in
            let resultData : Result<AllActivity,MyErrorType> = self.paresObject(result)
            switch resultData {
            case .Success(let data):
                self.allActivity = data
                self.collectionView.reloadData()
            case .Failure(let error):
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
                self.collectionView.reloadData()
            case .Failure(let error):
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
                self.collectionView.reloadData()
            case .Failure(let error):
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
                self.collectionView.reloadData()
            case .Failure(let error):
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
                self.courseActivity = data
                self.collectionView.reloadData()
            case .Failure(let error):
                self.dealWithError(error)
            }
            })
    }
    
}


