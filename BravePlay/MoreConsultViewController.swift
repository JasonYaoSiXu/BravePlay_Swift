//
//  MoreConsultViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MoreConsultViewController: UIViewController {
    private var answers: [(String,String,String,Bool)] = []
    private let cellIdentifier: String = "HeadDetailAcConsultTableViewCell"
    private let tableView: UITableView = UITableView()
    
    init(answers: [(String,String,String,Bool)]) {
        self.answers = answers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = UIColor.brownColor()
        automaticallyAdjustsScrollViewInsets = false
        addTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.alpha = 1
        navigationController?.navigationBar.hidden = false
        
        super.viewWillAppear(animated)
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "更多咨询"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    private func addTableView() {
        tableView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height)
        view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor ( red: 0.2157, green: 0.3137, blue: 0.3255, alpha: 1.0 )
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.rowHeight = 80
    }
    
}

extension MoreConsultViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? HeadDetailAcConsultTableViewCell else {
            return UITableViewCell()
        }
        cell.cellBgView.backgroundColor = UIColor.clearColor()
        cell.leftImageHead.hidden = false
        cell.rightImagHead.hidden = false
        
        // 0 body 1 nickName 2 avatar 3 who
        if !answers[indexPath.row].3 {
            cell.rightImagHead.hidden = true
            cell.nameLabel.textAlignment = .Left
            cell.leftImageHead.setImageWithURL(makeImageURL(answers[indexPath.row].2), defaultImage: UIImage(named: "find_mw_bg"))
            
        } else {
            cell.leftImageHead.hidden = true
            cell.nameLabel.textAlignment = .Right
            cell.rightImagHead.setImageWithURL(makeImageURL(answers[indexPath.row].2), defaultImage: UIImage(named: "find_mw_bg"))
        }
        cell.nameLabel.text = answers[indexPath.row].1
        cell.messageLabel.text = answers[indexPath.row].0
        
        return cell
    }
    
}

