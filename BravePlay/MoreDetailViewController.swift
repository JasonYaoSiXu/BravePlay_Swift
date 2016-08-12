//
//  MoreDetailViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MoreDetailViewController: UIViewController {

    private var scheduleContents: [ActivitysScheduleContents] = []
    private var singleContents: [ActivitysSingleContents] = []
    private let tableView: UITableView = UITableView()
    private let titleCellIdentifier: String = "MoreDetailTitleTableViewCell"
    private let scheduleCellIdentifier: String = "FastWebTableViewCell"
    private let scheduleWebCell = FastWebTableViewCell()
    private let singleWebCell = FastWebTableViewCell()
    
    init(scheduleContents: [ActivitysScheduleContents],singleContents: [ActivitysSingleContents]) {
        self.scheduleContents = scheduleContents
        self.singleContents = singleContents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1647, green: 0.1961, blue: 0.2196, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        scheduleWebCell.backgroundColor = UIColor.clearColor()
        scheduleWebCell.contentView.backgroundColor = UIColor.clearColor()
        singleWebCell.backgroundColor = UIColor.clearColor()
        singleWebCell.backgroundColor = UIColor.clearColor()
        setUI()
        setupCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "更多图文详情"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    func setupCell() {
        scheduleWebCell.needUpdateBlock = { [weak self] in
            self?.tableView.reloadData()
        }
        scheduleWebCell.loadHtmlString(scheduleContents[0].content.stringByReplacingOccurrencesOfString("data-src", withString: "src", options: NSStringCompareOptions.LiteralSearch, range: nil))
        
        if singleContents.count > 0 {
            singleWebCell.needUpdateBlock = { [weak self] in
                self?.tableView.reloadData()
            }
            singleWebCell.loadHtmlString(singleContents[0].content.stringByReplacingOccurrencesOfString("data-src", withString: "src", options: NSStringCompareOptions.LiteralSearch, range: nil))
        }
        
    }
    
    private func setUI() {
        tableView.frame = CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height - 64)
        tableView.backgroundColor = UIColor.clearColor()
        view.addSubview(tableView)
        tableView.separatorStyle = .None
        
        let nib = UINib(nibName: titleCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: titleCellIdentifier)
        tableView.registerClass(FastWebTableViewCell.self, forCellReuseIdentifier: scheduleCellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

extension MoreDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return scheduleContents.count + singleContents.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleContents.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        switch (indexPath.section, indexPath.row) {
        case (_, 0) :
            guard let cell = tableView.dequeueReusableCellWithIdentifier(titleCellIdentifier, forIndexPath: indexPath) as? MoreDetailTitleTableViewCell else {
                return UITableViewCell()
            }
            if indexPath.section == 0 {
                cell.titleLabel.text = "活动详情"
            } else {
                cell.titleLabel.text = singleContents[0].title
            }
            return cell
        case (0,_) :
            scheduleWebCell.setNeedsLayout()
            scheduleWebCell.selectionStyle = UITableViewCellSelectionStyle.None
            return scheduleWebCell
        default:
            singleWebCell.setNeedsLayout()
            singleWebCell.selectionStyle = UITableViewCellSelectionStyle.None
            return singleWebCell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (_, 0) :
                return tableView.rowHeight
        case (0,_) :
                return scheduleWebCell.requireRowHeight(tableView)
        default:
            return singleWebCell.requireRowHeight(tableView)
        }
    }
    
}

