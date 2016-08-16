//
//  TVSectionViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Result

class TVSectionViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    private var videosData: [TVSectionResponse] = []
    private let cellIdentifier: String = "UserCustomTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
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
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "TV"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }

    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 110)
        view.addSubview(tableView)
        
        tableView.rowHeight = 280
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TVSectionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? UserCustomTableViewCell else {
            return UITableViewCell()
        }
        
        let date = NSDate(timeIntervalSince1970: Double(videosData[indexPath.row].created_at))
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "MM-dd"
        cell.timeLabel.text = dateFormat.stringFromDate(date)
        cell.coverImageView.setImageWithURL(makeImageURL(videosData[indexPath.row].front_cover), defaultImage: UIImage(named: "find_mw_bg"))
        cell.titleLabel.text = videosData[indexPath.row].title
        cell.nameLabel.text = videosData[indexPath.row].topic.name
        
        cell.timeInfoLabel.text = {
            let mutines = videosData[indexPath.row].duration / 60
            let seconds = videosData[indexPath.row].duration % 60
            return "\(mutines)'\(seconds)"
        }()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let showVideos = HeadViewDetailForVideoViewController(name: videosData[indexPath.row].title, showId: "\(videosData[indexPath.row].id)")
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(showVideos, animated: true)
        hidesBottomBarWhenPushed = false
    }
    
}

//请求数据
extension TVSectionViewController : MoyaPares {
    
    private func requestData(page: Int) {
        
        TVSectionProvider.request(TVSection.TVVideos(page: page), completion: { [unowned self] result in
            self.showHud("正在加载")
            let resultdata : Result<[TVSectionResponse],MyErrorType> = self.paresObjectArray(result)
            switch resultdata {
            case .Success(let data) :
                self.videosData = data
                self.tableView.reloadData()
                self.popHud()
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        })
        
    }
    
}

