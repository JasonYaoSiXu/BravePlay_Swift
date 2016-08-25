//
//  ViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/7/29.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import ObjectMapper
import Result

protocol ViewControllerDelegate : class {
    func jumpToOtherViewController(index: Int)
}

class ViewController: UIViewController {

    private let sectionOne = "InterestingTableViewCell"
    private let sectionTitle = "SeciontTitleTableViewCell"
    private let sectionTwo = "BraveActiveTableViewCell"
    private let sectionThree = "BraveTVUITableViewCell"
    private let otherCellIdentifier = "CustomTableViewCell"
    private let tableView = UITableView()
    private let titleArray = ["敢玩趣闻","敢玩活动","敢玩TV","自频道精选","Topic推荐"]
    private var sectionCount : [String] = []
    private var imageInfoArray: [String] = []
    var bannerRepos: [BannerItem] = []
    var articleRepos: [ArticleItem] = []
    var activityRepos: ActivityResponse?
    var tvRepos: TvResponse?
    var channelRepos: ChannelResponse?
    var topicRepos: TopicResponse?
    var output: MainVcConnectRequest!
    var input: MainVcConnectDisplay!
    
    weak var delegate : ViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.2157, green: 0.3098, blue: 0.3255, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        setUpVIP()
        initTableView()
        output.requestBanner()
        showHud("加载中")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        navigationController?.navigationBar.barTintColor = UIColor( red: 0.0824, green: 0.1216, blue: 0.1412, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 41)
        tableView.backgroundColor = UIColor.clearColor()
        
        var nib = UINib(nibName: sectionOne, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: sectionOne)
        nib = UINib(nibName: sectionTitle, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: sectionTitle)
        nib = UINib(nibName: sectionTwo, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: sectionTwo)
        nib = UINib(nibName: sectionThree, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: sectionThree)
        nib = UINib(nibName: otherCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: otherCellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .None
        
        view.addSubview(tableView)
    }
    
    func setUpVIP() {
        let work = MainVcNetWork()
        self.output = work
        work.outputDisplay = self
        let disPlay = MainVcPresentData()
        work.outputPresent = disPlay
        disPlay.outputDisplay = self
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section >= 3 {
            return 2
        }
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        switch (indexPath.section,indexPath.row) {
        case (_, 0):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(sectionTitle, forIndexPath: indexPath) as? SeciontTitleTableViewCell else {
                return UITableViewCell()
            }
            
            if indexPath.section <= 2 {
                cell.action = { [unowned self] _ in
                    var index = indexPath.section + 1
                    if indexPath.section == 1 {
                        index = 3
                    } else if indexPath.section == 2 {
                        index = 2
                    }
                    self.delegate.jumpToOtherViewController(index)
                }
            } else if indexPath.section == 3 {
                cell.action = { [unowned self] _ in
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(ChannelsViewController(), animated: true)
                    self.hidesBottomBarWhenPushed = false
                }
            } else if indexPath.section == 4 {
                cell.action = { [unowned self] _ in
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(TopicsViewController(), animated: true)
                    self.hidesBottomBarWhenPushed = false
                }
            }
            
            cell.titleLabel.text = titleArray[indexPath.section]
            if indexPath.section >= 1 && sectionCount.count != 0 {
                    cell.jumpButton.setTitle(sectionCount[indexPath.section - 1] + ">", forState: .Normal)
            }
            
            return cell
        case (0, _):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(sectionOne, forIndexPath: indexPath) as? InterestingTableViewCell else {
                return UITableViewCell()
            }
            
            if articleRepos.count == 0 {
                return cell
            }
            
            cell.titleImageView.setImageWithURL(makeImageURL(articleRepos[indexPath.row - 1].cover), defaultImage: UIImage(named: "login_bg"))
            cell.titleInfoLabel.text = articleRepos[indexPath.row - 1].title
            cell.lookTimesLabel.text = "\(articleRepos[indexPath.row - 1].read_num)次"
            cell.authorTimeLabel.text = articleRepos[indexPath.row - 1].author
            
            return cell
        case (1, _):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(sectionTwo, forIndexPath: indexPath) as? BraveActiveTableViewCell else {
                return UITableViewCell()
            }
            
            guard let activity = activityRepos else {
                return cell
            }
            
            cell.addressLabel.text = activity.activityItem[indexPath.row - 1].s_location
            cell.bgImageView.setImageWithURL(makeImageURL(activity.activityItem[indexPath.row - 1].avatar), defaultImage: UIImage(named: "login_bg"))
            cell.priceLabel.text = activity.activityItem[indexPath.row - 1].expense
            cell.titleLabel.text = activity.activityItem[indexPath.row - 1].title
            
            return cell
        case (2, _):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(sectionThree, forIndexPath: indexPath) as? BraveTVUITableViewCell else {
                return UITableViewCell()
            }
            
            guard let tv = tvRepos else {
                return cell
            }
            
            cell.bgImageView.setImageWithURL(makeImageURL(tv.tvItem[indexPath.row - 1].front_cover), defaultImage: UIImage(named: "login_bg"))
            cell.titleLabel.text = tv.tvItem[indexPath.row - 1].title
            cell.nameLabel.text = tv.tvItem[indexPath.row - 1].name
            
            return cell
        case (3, _):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(otherCellIdentifier, forIndexPath: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            
            if channelRepos != nil {
                cell.reloadData()
                cell.delegate = self
            }
            return cell
        case (4, _):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(otherCellIdentifier, forIndexPath: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            
            if channelRepos != nil {
                    cell.isLastSection = true
                    cell.reloadData()
                    cell.delegate = self
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            return
        }
        switch indexPath.section {
        case 0:
            let intersetingVC = InterestingViewController(id: articleRepos[indexPath.row - 1].id,name: articleRepos[indexPath.row - 1].title)
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(intersetingVC, animated: true)
            hidesBottomBarWhenPushed = false
        case 1:
            let activityVC = HeadViewDetailViewController(showId: activityRepos!.activityItem[indexPath.row - 1].id, vcTitle: activityRepos!.activityItem[indexPath.row - 1].title)
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(activityVC, animated: true)
            hidesBottomBarWhenPushed = false
        case 2:
            let tvVC = HeadViewDetailForVideoViewController(name: tvRepos!.tvItem[indexPath.row - 1].title, showId: tvRepos!.tvItem[indexPath.row - 1].id)
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(tvVC, animated: true)
            hidesBottomBarWhenPushed = false
        default:
            return
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section,indexPath.row) {
        case (_,0):
            return 30
        case (0, _):
            return 100
        case (1, _):
            return 150
        case (2, _):
            return 150
        default:
            return 110
        }
    }
}

extension ViewController : HeadViewDelegate,CustomTableViewCellDelegate {
    
    func pushToHeadDetailVC(indexPath: (String,String,String)) {
        if indexPath.0 == "1" {
                hidesBottomBarWhenPushed = true
                let headVc = HeadViewDetailViewController(showId: indexPath.1,vcTitle: indexPath.2)
                headVc.title = indexPath.2
                navigationController?.pushViewController(headVc, animated: true)
                hidesBottomBarWhenPushed = false
        } else if indexPath.0 == "2" {
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(HeadViewDetailForVideoViewController(name: "\(indexPath.2)",showId: indexPath.1), animated: true)
            hidesBottomBarWhenPushed = false
        }
    }
    
    func showInfoWithCh(indexPath: Int) -> ChnnelItem {
        guard let channelRepos = self.channelRepos else {
            return ChnnelItem()
        }
        return channelRepos.dataList[indexPath]
    }
    
    func showInfoWithTop(indexPath: Int) -> TopicItem {
        guard let topicRepos = self.topicRepos else {
            return TopicItem()
        }
        return topicRepos.dataList[indexPath]
    }
    
    func tapCollectionView(indePath: Int,isLastSection: Bool) {
        if isLastSection == false {
            let channelVc = UserVcViewController(userId: "\(channelRepos!.dataList[indePath].id)", userName: channelRepos!.dataList[indePath].name,isLast: isLastSection)
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(channelVc, animated: true)
            hidesBottomBarWhenPushed = false
        } else {
            let channelVc = UserVcViewController(userId: "\(topicRepos!.dataList[indePath].id)", userName: topicRepos!.dataList[indePath].name,isLast: isLastSection)
            hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(channelVc, animated: true)
            hidesBottomBarWhenPushed = false
        }
    }
    
}

extension ViewController : MainVcConnectDisplay {
    
    func displayBanner(displayData: Result<[BannerItem], MyErrorType>) {
        switch displayData {
        case .Success(let respone):
            self.bannerRepos = respone
            let headView = HeadView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 210), bannerItem: self.bannerRepos)
            headView.delegate = self
            self.tableView.tableHeaderView = headView
            self.output.requestArticle()
        case .Failure(let error):
            dealWithError(error)
            popHud()
        }
    }
    
    func displayArticle(displayData: [ArticleItem]?, error: MyErrorType?) {
        if let resultData = displayData {
            self.articleRepos = resultData
            self.output.requestActivity()
            self.tableView.beginUpdates()
            let indexSet = NSIndexSet(index: 0)
            self.tableView.reloadSections(indexSet, withRowAnimation: .None)
            self.tableView.endUpdates()
        } else {
            dealWithError(error!)
            popHud()
        }
    }
    
    func displayActivity(displayData: ActivityResponse?, error: MyErrorType?) {
        if let resultData = displayData {
            self.activityRepos = resultData
            self.sectionCount.append(resultData.count)
            self.output.requestTV()
            self.tableView.beginUpdates()
            let indexSet = NSIndexSet(index: 1)
            self.tableView.reloadSections(indexSet, withRowAnimation: .None)
            self.tableView.endUpdates()
        } else {
            dealWithError(error!)
            popHud()
        }
    }
    
    func displayTV(displayData: TvResponse?, error: MyErrorType?) {
        if let resultData = displayData {
            self.tvRepos = resultData
            self.sectionCount.append(resultData.count)
            self.output.requestChannel()
            self.tableView.beginUpdates()
            let indexSet = NSIndexSet(index: 2)
            self.tableView.reloadSections(indexSet, withRowAnimation: .None)
            self.tableView.endUpdates()
        } else {
            dealWithError(error!)
            popHud()
        }
    }
    
    func displayChannel(displayData: Result<ChannelResponse, MyErrorType>) {
        switch displayData {
        case .Success(let response):
            self.channelRepos = response
            self.sectionCount.append(response.count)
            self.output.requestTopic()
            self.tableView.beginUpdates()
            let indexSet = NSIndexSet(index: 3)
            self.tableView.reloadSections(indexSet, withRowAnimation: .None)
            self.tableView.endUpdates()
        case .Failure(let error):
            popHud()
            dealWithError(error)
        }
    }
    
    func displayTopic(displayData: Result<TopicResponse, MyErrorType>) {
        switch displayData {
        case .Success(let response):
            self.topicRepos = response
            self.sectionCount.append(response.count)
            self.popHud()
            self.tableView.beginUpdates()
            let indexSet = NSIndexSet(index: 4)
            self.tableView.reloadSections(indexSet, withRowAnimation: .None)
            self.tableView.endUpdates()
        case .Failure(let error):
            dealWithError(error)
        }
    }
}