//
//  ChannelsViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/24.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Result

class ChannelsViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    private let cellIdentifier: String = "MineCareTableViewCell"
    private var userCareData = UserCareList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "自频道精选"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        initTableView()
        requestData(1)
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
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 74, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 74)
        view.addSubview(tableView)
        tableView.backgroundColor = view.backgroundColor
        tableView.rowHeight = 151
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ChannelsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCareData.models.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? MineCareTableViewCell else {
            return UITableViewCell()
        }
        
        cell.descirptionLabel.hidden = false
        cell.careButton.hidden = false
        cell.delegate = self
        cell.descirptionLabel.text = userCareData.models[indexPath.row].description
        cell.typeLabel.text = userCareData.models[indexPath.row].name
        cell.headImageView.setImageWithURL(makeImageURL(userCareData.models[indexPath.row].avatar), defaultImage: UIImage(named: "find_mw_bg"))
        
        cell.takeData = { [unowned self] _ in
            return (self.userCareData.models[indexPath.row],indexPath.row)
        }
        cell.customCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tapCareCellIsLast(indexPath.row)
    }
    
}

extension ChannelsViewController : MoyaPares,MineCareTableViewCellDelegate {
    
    private func requestData(page: Int) {
        MainSectionProvider.request(MainSection.Channelsdata(page: page), completion: { [unowned self] result in
            let resultData : Result<[ChannelsData],MyErrorType> = self.paresObjectArray(result)
            switch resultData {
            case .Success(let data):
                self.userCareData = self.transModel(data)
                self.tableView.reloadData()
            case .Failure(let error):
                self.dealWithError(error)
            }
        })
    }
    
    private func transModel(channelsData: [ChannelsData]) -> UserCareList {
        var userCareData = UserCareList()
        for enumInfo in channelsData {
            var userCare = UserCare()
            userCare.id = enumInfo.id
            userCare.name = enumInfo.name
            userCare.type = "\(enumInfo.type)"
            userCare.avatar = enumInfo.avatar
            userCare.url = enumInfo.url
            userCare.description = enumInfo.description
            userCare.headimg = enumInfo.headimg
            userCare.pc_headimg = enumInfo.pc_headimg
            
            for detailInfo in enumInfo.videos {
                var videoes = UserCareVideos()
                videoes.id = "\(detailInfo.id)"
                videoes.title = detailInfo.title
                videoes.channel_id = detailInfo.channel_id
                videoes.topic_id = detailInfo.topic_id
                videoes.duration = detailInfo.duration
                videoes.front_cover = detailInfo.front_cover
                videoes.created_at = detailInfo.created_at
                videoes.updated_at = detailInfo.updated_at
                userCare.videos.append(videoes)
            }
            userCareData.models.append(userCare)
        }
        return userCareData
    }
    
    func tapCareCell(indexModel: Int, index: Int) {
        let vc = HeadViewDetailForVideoViewController(name: userCareData.models[indexModel].videos[index].title, showId: userCareData.models[indexModel].videos[index].id)
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tapCareCellIsLast(index: Int) {
        let vc = UserVcViewController(userId: "\(userCareData.models[index].id)", userName: userCareData.models[index].name, isLast: false)
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }    
    
}

