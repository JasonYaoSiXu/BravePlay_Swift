//
//  HeadViewDetailViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Result
import ObjectMapper

class HeadViewDetailViewController: UIViewController {
    
    private let height : CGFloat = 50
    private let priceLabel = UILabel()
    private let joinButton = UIButton(type: UIButtonType.Custom)
    private let tableView = UITableView()
    private var titleStr: String = ""
    private let sectionTitleIdentifier: String = "SeciontTitleTableViewCell"
    private let firstSectionIdentifier: String = "HeadViewAcFirstSectionTableViewCell"
    private let secondeSectionIdentifier: String = "HeadDetalAcCustomTableViewCell"
    private let thirdSectionIdentifier: String = "HeadDetailAcConsultTableViewCell"
    private let customButton: String = "CustomButtonTableViewCell"
    private let titleName: [String] = ["基本信息","敢玩Tips","敢玩咨询"]
    private var customView: HeadDetailAcCustomView!
    private var number = 0
    private var ticketInfo: [TicketInfo] = []
    private var vcTitle: String = ""
    private var answers: [(String,String,String,Bool)] = []
    
    var cellHeight: CGFloat = 100
    var lastSectionCellHeight: CGFloat = 100
    var showId: String = ""
    
    var consultDetail: [ConsultDetail] = []
    var activityDetail: ActivitysReponse = ActivitysReponse()
    
    init(showId: String,vcTitle: String) {
        self.showId = showId
        self.vcTitle = vcTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.2157, green: 0.3098, blue: 0.3255, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = vcTitle
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        setTableView()
        setUI()
        connectDetailActivity(showId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 0
        navigationController?.navigationBar.barTintColor = UIColor( red: 0.0824, green: 0.1216, blue: 0.1412, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        let likeButton = UIBarButtonItem()
        likeButton.title = "like"
        let shareButton = UIBarButtonItem(title: "share", style: .Done, target: self, action: #selector(HeadViewDetailViewController.shareAction))
        let leftButtonItems = [shareButton,likeButton]
        navigationItem.rightBarButtonItems = leftButtonItems
    }
    
    private func setTableView() {
        tableView.backgroundColor = UIColor.clearColor()
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - height - 10)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        var nib = UINib(nibName: firstSectionIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: firstSectionIdentifier)
        nib = UINib(nibName: sectionTitleIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: sectionTitleIdentifier)
        nib = UINib(nibName: secondeSectionIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: secondeSectionIdentifier)
        nib = UINib(nibName: thirdSectionIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: thirdSectionIdentifier)
        nib = UINib(nibName: customButton, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: customButton)
        
        view.addSubview(tableView)
    }
    
    private func setUI() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height

        priceLabel.frame = CGRect(x: 0, y: screenHeight - height, width: screenWidth * 0.38, height: height)
        priceLabel.textAlignment = .Center
        priceLabel.text = "¥249"
        priceLabel.textColor = UIColor ( red: 0.3294, green: 0.149, blue: 0.0039, alpha: 1.0 )
        priceLabel.backgroundColor = UIColor ( red: 0.8667, green: 0.6039, blue: 0.0706, alpha: 1.0 )
        priceLabel.alpha = 0.8
        view.addSubview(priceLabel)
        
        joinButton.frame = CGRect(x: screenWidth * 0.4, y: screenHeight - height, width: screenWidth * 0.6, height: height)
        joinButton.backgroundColor = UIColor ( red: 0.8667, green: 0.6039, blue: 0.0706, alpha: 1.0 )
        joinButton.setTitle("立即报名", forState: .Normal)
        joinButton.setTitleColor(UIColor ( red: 0.3294, green: 0.149, blue: 0.0039, alpha: 1.0 ), forState: .Normal)
        joinButton.alpha = 0.8
        view.addSubview(joinButton)
        joinButton.addTarget(self, action: #selector(HeadViewDetailViewController.tapJoinButton), forControlEvents: .TouchUpInside)
    }
    
    @objc private func tapJoinButton() {
        print("\(#function)")
        ticketInfo.append(TicketInfo("单人早鸟票",ticketRemak: "请在备注中选择课程",ticketPrice: "399",ticketId: "123"))
        ticketInfo.append(TicketInfo("双人早鸟票",ticketRemak: "请在备注中选择课程",ticketPrice: "399",ticketId: "123"))
        ticketInfo.append(TicketInfo("三人早鸟票",ticketRemak: "请在备注中选择课程",ticketPrice: "399",ticketId: "123"))
        BuyTicketView.showBuyTicket(ticketInfo)
        BuyTicketView.delegate = self
    }
    
    @objc private func shareAction() {
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
    
}

extension HeadViewDetailViewController : BuyTicketViewDelegate {
    func tapIndex(index: Int) {
        let ticketId = ticketInfo[index].ticketId
        let price = ticketInfo[index].ticketPrice
        let orderVc = OrderDetailViewController(activityId: "123456", ticketId: ticketId, ticketPrice: price)
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(orderVc, animated: true)
    }
}

extension HeadViewDetailViewController :  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("\(#function)")
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(#function)")
        switch section {
        case 0:
            return 4
        case 1:
            return activityDetail.tipContents.count + 3
        default:
            if consultDetail.count > 0 {
                
                consultDetail.forEach({
                    if $0.answers.count > 0 {
                        number += 1
                    }
                })
                return consultDetail.count + number + 2
            } else {
                return consultDetail.count + 2
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 15))
        view.backgroundColor = UIColor ( red: 0.2157, green: 0.3098, blue: 0.3255, alpha: 1.0 )
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("\(#function)")
        switch (indexPath.section, indexPath.row) {
        case (_, 0):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(sectionTitleIdentifier, forIndexPath: indexPath) as? SeciontTitleTableViewCell else{
                return UITableViewCell()
            }
            cell.jumpButton.hidden = true
            cell.titleLabel.textColor = UIColor.whiteColor()
            cell.titleLabel.text = titleName[indexPath.section]
            
            return cell
        case (0, _) :
            guard let cell = tableView.dequeueReusableCellWithIdentifier(firstSectionIdentifier, forIndexPath: indexPath) as? HeadViewAcFirstSectionTableViewCell else {
                return UITableViewCell()
            }
            
            switch indexPath.row {
            case 1:
                cell.titleLabel.text = "08月27日 08月28日"
                cell.titleImageView.image = UIImage(named: "ticket_buy_click")
            case 2:
                cell.jumpButton.hidden = false
                cell.titleLabel.text = activityDetail.location
                cell.titleImageView.image = UIImage(named: "find_venue_place")
            default:
                cell.titleLabel.text = activityDetail.contact
                cell.titleImageView.image = UIImage(named: "phone")
            }
            return cell
        case (1, _):

            if indexPath.row == activityDetail.tipContents.count + 2 {
                guard let cell = tableView.dequeueReusableCellWithIdentifier(customButton) as? CustomButtonTableViewCell else {
                    return UITableViewCell()
                }
                cell.jumpButton.setTitle("更多图文详情", forState: .Normal)
                cell.action = { [unowned self] _ in
                    let moreDetailVc = MoreDetailViewController(scheduleContents: self.activityDetail.scheduleContents,singleContents: self.activityDetail.singleContents)
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(moreDetailVc, animated: true)
                }
                cellHeight = 44
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCellWithIdentifier(secondeSectionIdentifier) as? HeadDetalAcCustomTableViewCell else {
                return UITableViewCell()
            }
            
            if indexPath.row == 1 || activityDetail.tipContents.count == 0 {
                cell.titleLabel.text = "玩什么"
                if activityDetail.scheduleContents.count > 0 {
                    cell.infoLabel.text = activityDetail.scheduleContents[0].title
                } else {
                    cell.infoLabel.text = "加班狗"
                }
                cellHeight = cell.cellHeight()
                return cell
            }
            
            cell.titleLabel.text = activityDetail.tipContents[indexPath.row-2].title
            cell.infoLabel.text = activityDetail.tipContents[indexPath.row-2].content
            cellHeight = cell.cellHeight()
            
            return cell
        default:
            
            if indexPath.row == consultDetail.count + number + 1 {
                guard let cell = tableView.dequeueReusableCellWithIdentifier(customButton) as? CustomButtonTableViewCell else {
                    return UITableViewCell()
                }
                cell.jumpButton.setTitle("更多咨询", forState: .Normal)
                cell.action = { [unowned self] _ in
                    let consultVC = MoreConsultViewController(answers: self.answers)
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(consultVC, animated: true)
                }
                lastSectionCellHeight = 44
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCellWithIdentifier(thirdSectionIdentifier) as? HeadDetailAcConsultTableViewCell else {
                return UITableViewCell()
            }
            
            if consultDetail.count == 0 {
                cell.hidden = true
                return cell
            }
            
            cell.leftImageHead.hidden = false
            cell.rightImagHead.hidden = false
            
            // 0 body 1 nickName 2 avatar 3 who
            if !answers[indexPath.row - 1].3 {
                cell.rightImagHead.hidden = true
                cell.nameLabel.textAlignment = .Left
                cell.leftImageHead.setImageWithURL(makeImageURL(answers[indexPath.row - 1].2), defaultImage: UIImage(named: "find_mw_bg"))

            } else {
                cell.leftImageHead.hidden = true
                cell.nameLabel.textAlignment = .Right
                cell.rightImagHead.setImageWithURL(makeImageURL(answers[indexPath.row - 1].2), defaultImage: UIImage(named: "find_mw_bg"))
            }
            cell.nameLabel.text = answers[indexPath.row - 1].1
            cell.messageLabel.text = answers[indexPath.row - 1].0
            lastSectionCellHeight = cell.cellHeight()
            
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("\(#function)")
        switch (indexPath.section, indexPath.row) {
        case (_ ,0):
            return 44
        case (0, _):
            return 44
        case (1, _):
            return cellHeight
        default:
            return lastSectionCellHeight
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 3 {
                callPhone(activityDetail.contact)
            } else if indexPath.row == 2 {
                let mapView = MapVCViewController()
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(mapView, animated: true)
            }
        }
    }
    
    func callPhone(phoneNumber: String) {
        let alter = UIAlertController(title: "拨打电话", message: "", preferredStyle: .ActionSheet)
        alter.addAction(UIAlertAction(title: phoneNumber, style: .Default, handler: { _ in
            guard let phoneURL = NSURL(string: "tel://\(phoneNumber)") else {
                return
            }
            UIApplication.sharedApplication().openURL(phoneURL)
        }))
        alter.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        presentViewController(alter, animated: true, completion: nil)
    }
    
    
}

//联网操作
extension HeadViewDetailViewController : MoyaPares {
    
    //活动详情
    func connectDetailActivity(activityId: String) {
        self.showHud("正在加载")
        MainSectionProvider.request(MainSection.Activitys(id: activityId)) { [unowned self] result in
            let resultData: Result<ActivitysReponse, MyErrorType> = self.paresObject(result)
            switch resultData {
            case .Success(let response):
                self.activityDetail = response
                var bannerItem : [BannerItem] = []
                response.avatarGallery.forEach({
                    var item = BannerItem()
                    item.img_mobile_url = $0.url
                    bannerItem.append(item)
                })
                let headView = HeadView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 280), bannerItem: bannerItem)
                headView.currentPageColor = UIColor ( red: 0.5098, green: 0.7529, blue: 0.3294, alpha: 1.0 )
                headView.locationOfPageControl(PageControlLocation.BottomRight)
                headView.isCircle = false
                self.customView = HeadDetailAcCustomView(frame: CGRect(x: 0, y: headView.bounds.size.height / 3 * 2, width: headView.bounds.size.width, height: headView.bounds.size.height / 3))
                headView.addSubview(self.customView)
                self.customView.circleImageView.setImageWithURL(makeImageURL(response.headimg), defaultImage: UIImage(named: "find_mw_bg"))
                self.customView.authorLabel.text = "by  " + response.name
                self.customView.activityInfo.text = response.title
                self.tableView.tableHeaderView = headView
                self.connectConsultActivity(activityId)
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        }
    }
    
    //活动咨询
    func connectConsultActivity(activityId: String) {
        MainSectionProvider.request(MainSection.HotActivityid(id: activityId)) { [unowned self] result in
            let resultData: Result<[ConsultDetail] ,MyErrorType> = self.paresObjectArray(result)
            self.answers.removeAll()
            switch resultData {
            case .Success(let response):
                self.consultDetail = response
                self.consultDetail.forEach({
                    let item = ($0.body,$0.userDetail.nickname,$0.userDetail.avatar,false)
                    self.answers.append(item)
                    $0.answers.forEach({
                        let item = ($0.body,$0.userDetail.nickname,$0.userDetail.avatar,true)
                        self.answers.append(item)
                    })
                })
                self.tableView.reloadData()
                self.popHud()
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        }
    }
    
}