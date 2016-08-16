//
//  HeadViewDetailForVideoViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Result

class HeadViewDetailForVideoViewController: UIViewController,MoyaPares {
    
    private var titleName: String = ""
    private var showId: String = ""
    private let tableView: UITableView =  UITableView()
    private let sectionTitleCellIdentifier: String = "OrderDetailCellTitleTableViewCell"
    private let recommendCellIdentifier: String = "DetailForTvRecommendTableViewCell"
    private let recommendUserCellIdentifier: String = "relatedRecommendTableViewCell"
    private let commentCellIdentifier: String = "DetailForTvCommentTableViewCell"
    private var haedView: DetailForTvCustomHeadView!
    private var videos: VideosResponse = VideosResponse()
    private var barragesArray: [VideosBarrages] = []
    private var recommendArray: [VideosRecommends] = []
    private let titleArray: [String] = ["相关推荐","评论"]
    
    init(name: String, showId: String) {
        self.titleName = name
        self.showId = showId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1725, green: 0.2667, blue: 0.298, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = titleName
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        requestVideosData(showId)
        setTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 0.0
        navigationController?.navigationBar.barTintColor = UIColor( red: 0.0824, green: 0.1216, blue: 0.1412, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        let likeButton = UIBarButtonItem()
        likeButton.title = "like"
        let shareButton = UIBarButtonItem(title: "share", style: .Done, target: self, action: #selector(HeadViewDetailForVideoViewController.tapShareButton))
        let leftButtonItems = [shareButton,likeButton]
        navigationItem.rightBarButtonItems = leftButtonItems
    }
    
    func setTableView() {
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor ( red: 0.1725, green: 0.2667, blue: 0.298, alpha: 1.0 )
        tableView.separatorStyle = .SingleLineEtched
        haedView = DetailForTvCustomHeadView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.height / 3 * 2))
        tableView.tableHeaderView = haedView
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 100
        
        var nib = UINib(nibName: recommendCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: recommendCellIdentifier)
        nib = UINib(nibName: recommendUserCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: recommendUserCellIdentifier)
        nib = UINib(nibName: commentCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: commentCellIdentifier)
        nib = UINib(nibName: sectionTitleCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: sectionTitleCellIdentifier)
    }
    
    @objc private func tapShareButton() {
        ShardView.show([
            ActionItem("微信") { _ in
                print("分享到微信")
            },
            ActionItem("朋友圈") { _ in
                print("分享到朋友圈")
            },
            ActionItem("QQ") { _ in
                print("QQ")
            },
            ActionItem("微博") { _ in
                print("微博")
            }
            ])
    }
    
    //滑动tableView显示navigation Bar
    func scrollViewDidScroll(scrollView: UIScrollView) {
        navigationController?.navigationBar.alpha = tableView.contentOffset.y / 150
    }
    
    func requestVideosData(id: String) {
        showHud("正在加载")
        MainSectionProvider.request(MainSection.Videos(id: id)) { [unowned self] result in
            let data: Result<VideosResponse, MyErrorType> = self.paresObject(result)
            switch data {
            case .Success(let result):
                self.videos = result
                self.haedView.imageView.setImageWithURL(makeImageURL(result.front_cover), defaultImage: UIImage(named: "find_mw_bg"))
                self.haedView.titleLabel.text = result.title
                self.haedView.timeLabel.text = {
                    let minutes = result.duration / 60
                    let seconds = result.duration % 60
                    return "----- Time\(minutes)'\(seconds) -----"
                }()
                self.haedView.detailLabel.text = result.detail.content
                self.haedView.tapButtonActions = {
                    let palyVc = PlayTvViewController(playId: self.videos.detail.play_url, barrages: self.barragesArray)
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(palyVc, animated: true)
                }
                self.requestRecommendData(id)
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        }
    }
    
    func requestRecommendData(id: String) {
        MainSectionProvider.request(MainSection.Recommends(id: id)) { [unowned self] result in
            let data: Result<[VideosRecommends], MyErrorType> = self.paresObjectArray(result)
            switch data {
            case .Success(let result):
                self.recommendArray = result
                self.requestCommentData(id)
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        }
    }
    
    func requestCommentData(id: String) {
        MainSectionProvider.request(MainSection.Barrages(id: id)) { [unowned self] result in
            let data: Result<[VideosBarrages], MyErrorType> = self.paresObjectArray(result)
            switch data {
            case .Success(let result):
                self.popHud()
                self.barragesArray = result
                self.tableView.reloadData()
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        }
    }
    
}

extension HeadViewDetailForVideoViewController :  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if recommendArray.count == 0 {
                return 1
            }
            return recommendArray.count + 2
        default:
            if barragesArray.count == 0 {
                return 1
            }
            return barragesArray.count + 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (_, 0):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(sectionTitleCellIdentifier, forIndexPath: indexPath) as? OrderDetailCellTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.remarksLabel.text = titleArray[indexPath.section]
            return cell
        case  (0, _):
            if recommendArray.count == 0 {
                return UITableViewCell()
            }
            if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCellWithIdentifier(recommendUserCellIdentifier, forIndexPath: indexPath) as? relatedRecommendTableViewCell else {
                    return UITableViewCell()
                }
                cell.nickLabel.text = videos.channel.name
                cell.personLabel.text = videos.channel.description
                cell.headImageView.setImageWithURL(makeImageURL(videos.channel.avatar), defaultImage: UIImage(named: "find_mw_bg"))
                return cell
            }
            guard let cell = tableView.dequeueReusableCellWithIdentifier(recommendCellIdentifier, forIndexPath: indexPath) as? DetailForTvRecommendTableViewCell else {
                return UITableViewCell()
            }
            let imageUrl = recommendArray[indexPath.row - 2].front_cover
            cell.titleImageView.setImageWithURL(makeImageURL(imageUrl), defaultImage: UIImage(named: "find_mw_bg"))
            cell.titleLabel.text = recommendArray[indexPath.row - 2].title
            cell.typeLabel.text = recommendArray[indexPath.row - 2].topic.name
            cell.timeLenLabel.text = {
                let minutes = recommendArray[indexPath.row - 2].duration / 60
                let seconds = recommendArray[indexPath.row - 2].duration % 60
                return "\(minutes)'\(seconds)"
            }()
            cell.authorlabel.text = "by " + videos.channel.name
            return cell
        case (1, _):
            if barragesArray.count == 0 {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCellWithIdentifier(commentCellIdentifier, forIndexPath: indexPath) as? DetailForTvCommentTableViewCell else {
                return UITableViewCell()
            }
            cell.headImageView.setImageWithURL(makeImageURL(barragesArray[indexPath.row - 1].userDetail.avatar), defaultImage: UIImage(named: "find_mw_bg"))
            cell.nickLabel.text = barragesArray[indexPath.row - 1].userDetail.nickname
            let date = NSDate(timeIntervalSince1970: Double(barragesArray[indexPath.row - 1].created_at))
            let dateFormate = NSDateFormatter()
            dateFormate.dateFormat = "MM-dd"
            let dateStr = dateFormate.stringFromDate(date)
            cell.timeLabel.text = dateStr
            cell.bodyLabel.text = barragesArray[indexPath.row - 1].content
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0  {
            if indexPath.row > 1 {
                let headTv: HeadViewDetailForVideoViewController = HeadViewDetailForVideoViewController(name: recommendArray[indexPath.row - 2].title, showId: "\(recommendArray[indexPath.row - 2].id)")
                hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(headTv, animated: true)
            } else if indexPath.row == 1 {
                let headTv: UserVcViewController = UserVcViewController(userId: "\(videos.channel.id)", userName: videos.channel.name,isLast: false)
                hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(headTv, animated: true)
            }
        }
        
    }
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor ( red: 0.1725, green: 0.2667, blue: 0.298, alpha: 1.0 )
        return view
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView()
            view.backgroundColor = UIColor ( red: 0.1725, green: 0.2667, blue: 0.298, alpha: 1.0 )
            return view
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (_, 0):
            return 44
        case (0, _):
            if indexPath.row == 1 {
                return 44
            }
            return 80
        default:
            return 80
        }
    }
    
}
