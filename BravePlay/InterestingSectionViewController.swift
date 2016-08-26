//
//  InterestingSectionViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/15.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Result

class InterestingSectionViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    private var interestingBannerData: [InterestingBanners] = []
    private var interestingDetailData: [InterestingSectionDetail] = []
    private let sectionOne = "InterestingTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        initTableView()
        requestBannerData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 1.0
        
        navigationController?.navigationBar.barTintColor = UIColor( red: 0.0824, green: 0.1216, blue: 0.1412, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "趣闻"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 110)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = .None
        tableView.rowHeight = 95
        
        let nib = UINib(nibName: sectionOne, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: sectionOne)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension InterestingSectionViewController : MoyaPares {
    
    private func requestBannerData() {
        IntersetingSectionProvider.request(IntersetingSection.Banners, completion: { [unowned self] result in
            self.showHud("正在加载")
            let dataResult : Result<[InterestingBanners],MyErrorType> = self.paresObjectArray(result)
            switch dataResult {
            case .Success(let data) :
                 self.interestingBannerData = data
                 var bannerItem: [BannerItem] = []
                 data.forEach({
                    var item = BannerItem()
                    item.dist_id = $0.id
                    item.img_mobile_url = $0.cover
                    item.description = $0.title
                    bannerItem.append(item)
                 })
                 let headView = HeadView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 210), bannerItem: bannerItem)
                 headView.centerOfPageControl = CGPoint(x: headView.center.x, y: 10)
                 headView.currentPageColor = UIColor ( red: 0.8588, green: 0.1686, blue: 0.2196, alpha: 1.0 )
                 headView.delegate = self
                 self.tableView.tableHeaderView = headView
                self.requestDetailData()
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        })
    }

    private func requestDetailData() {
        IntersetingSectionProvider.request(IntersetingSection.InterestDetail(page: 1), completion: { [unowned self] result in
            self.showHud("正在加载")
            let dataResult : Result<[InterestingSectionDetail],MyErrorType> = self.paresObjectArray(result)
            switch dataResult {
            case .Success(let data) :
                self.interestingDetailData = data
                self.popHud()
                self.tableView.reloadData()
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
            })
    }
}

extension InterestingSectionViewController :  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 15))
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestingDetailData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(sectionOne, forIndexPath: indexPath) as? InterestingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleImageView.setImageWithURL(makeImageURL(interestingDetailData[indexPath.row].cover), defaultImage: UIImage(named: "login_bg"))
        cell.titleInfoLabel.text = interestingDetailData[indexPath.row].title
        cell.lookTimesLabel.text = "\(interestingDetailData[indexPath.row].read_num)次"
        cell.authorTimeLabel.text = interestingDetailData[indexPath.row].author
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let intersetingVC = InterestingViewController(id: interestingDetailData[indexPath.row].id,name: interestingDetailData[indexPath.row].title)
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(intersetingVC, animated: true)
        hidesBottomBarWhenPushed = false
    }
}


extension InterestingSectionViewController : HeadViewDelegate {
    
    func pushToHeadDetailVC(indexPath: (String,String,String)) {
        hidesBottomBarWhenPushed = true
        let headVc = InterestingViewController(id: indexPath.1,name: indexPath.2)
        headVc.title = indexPath.2
        navigationController?.pushViewController(headVc, animated: true)
        hidesBottomBarWhenPushed = false
    }
}


