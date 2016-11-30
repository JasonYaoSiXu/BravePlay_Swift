//
//  InterestingViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/15.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Result

class InterestingViewController: UIViewController,MoyaPares {

    var id: String = ""
    var name: String = ""
    private let tableView: UITableView = UITableView()
    private let scheduleCellIdentifier: String = "FastWebTableViewCell"
    private let scheduleWebCell = FastWebTableViewCell()
    private var data: InterestingResponse = InterestingResponse()
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.2, green: 0.298, blue: 0.3098, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false
        initTableView()
        requestData(id)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = name
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 1.0
        
        let rightButton = UIBarButtonItem(title: "share", style: .Done, target: self, action: #selector(InterestingViewController.tapShareButton))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func requestData(id: String) {
        MainSectionProvider.request(MainSection.ArticleDetail(id: id), completion: { [unowned self] result in
            self.showHud("正在加载")
            let resultData : Result<InterestingResponse,MyErrorType> = self.paresObject(result)
            switch resultData {
            case .Success(let data):
                print("data ------>= \(data)")
                self.data = data
                self.setupCell()
                self.popHud()
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
            
        })
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 64)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor ( red: 0.2, green: 0.298, blue: 0.3098, alpha: 1.0 )
        tableView.tableFooterView = UIView()
        tableView.registerClass(FastWebTableViewCell.self, forCellReuseIdentifier: scheduleCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCell() {
        scheduleWebCell.needUpdateBlock = { [weak self] in
            self?.tableView.reloadData()
        }
        let urlStr = data.detail.content.stringByReplacingOccurrencesOfString("src=\"\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let html = urlStr.stringByReplacingOccurrencesOfString("data-src", withString: "src", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let htmlString = html.componentsSeparatedByString("\n")
        var string = ""
        htmlString.forEach({
            if $0.containsString("pic stage anim blur-img blur_img") == false {
                string.appendContentsOf($0)
            }
        })
        scheduleWebCell.loadHtmlString(string)
        
    }
    
    @objc func tapShareButton() {
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
    
}


extension InterestingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        scheduleWebCell.backgroundColor = UIColor ( red: 0.0902, green: 0.102, blue: 0.1176, alpha: 1.0 )
        scheduleWebCell.contentView.backgroundColor = UIColor ( red: 0.0902, green: 0.102, blue: 0.1176, alpha: 1.0 )
        scheduleWebCell.setNeedsLayout()
        scheduleWebCell.selectionStyle = UITableViewCellSelectionStyle.None
        return scheduleWebCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return scheduleWebCell.requireRowHeight(tableView)
    }
    
}
