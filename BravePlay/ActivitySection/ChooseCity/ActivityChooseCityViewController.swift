//
//  ActivityChooseCityViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit
import Result

protocol ActivityChooseCityViewControllerDelegate: class {
    func takeChooseCity(chooseCity: String)
}

class ActivityChooseCityViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    private var chooseCityButton: UIButton = UIButton()
    private var finishButton: UIButton = UIButton()
    
    private var cityList: [Location] = []
    private var chooseCity: String = ""
    weak var delegate: ActivityChooseCityViewControllerDelegate!
    private let cellIdentifier: String = "UITableViewCell"
    
    init(chooseCity: String) {
        self.chooseCity = chooseCity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.2863, green: 0.3333, blue: 0.3725, alpha: 1.0 )
        addButtons()
        addTableView()
        requestCityList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    private func addButtons() {
        view.addSubview(chooseCityButton)
        chooseCityButton.snp.makeConstraints(closure: { make in
            make.top.equalTo(50)
            make.left.equalTo(20)
        })
        chooseCityButton.backgroundColor = UIColor.clearColor()
        
        if chooseCity == "" {
            chooseCityButton.setTitle("全国", forState: .Normal)
        } else {
            chooseCityButton.setTitle(chooseCity, forState: .Normal)
        }
        chooseCityButton.setTitleColor(UIColor ( red: 0.9333, green: 0.6039, blue: 0.0588, alpha: 1.0 ), forState: .Normal)
        chooseCityButton.addTarget(self, action: #selector(ActivityChooseCityViewController.dismissSelf), forControlEvents: .TouchUpInside)
        
        view.addSubview(finishButton)
        finishButton.snp.makeConstraints(closure: { make in
            make.top.equalTo(50)
            make.right.equalTo(-30)
        })
        finishButton.setTitle("完成", forState: .Normal)
        finishButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        finishButton.addTarget(self, action: #selector(ActivityChooseCityViewController.dismissSelf), forControlEvents: .TouchUpInside)
        
        let spaceView = UIView()
        view.addSubview(spaceView)
        spaceView.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(self.finishButton.snp.bottom).offset(30)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
        })
        spaceView.backgroundColor = UIColor ( red: 0.3843, green: 0.4196, blue: 0.451, alpha: 1.0 )
    }
    
    @objc private func dismissSelf() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func addTableView() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(self.finishButton.snp.bottom).offset(31)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        })
        
        tableView.rowHeight = 60
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ActivityChooseCityViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 30))
        headView.backgroundColor = UIColor ( red: 0.2196, green: 0.2549, blue: 0.2902, alpha: 1.0 )
        
        let titleLable = UILabel()
        headView.addSubview(titleLable)
        titleLable.snp.makeConstraints(closure: { make in
            make.centerY.equalTo(headView.snp.centerY)
            make.left.equalTo(15)
        })
        titleLable.textColor = UIColor ( red: 0.7333, green: 0.7451, blue: 0.7569, alpha: 1.0 )
        titleLable.text = "热门城市"
        titleLable.sizeToFit()
        
        return headView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = cityList[indexPath.row].title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if cityList.count > 0 {
            delegate.takeChooseCity(cityList[indexPath.row].title)
        } else {
            delegate.takeChooseCity("全国")
        }
        dismissViewControllerAnimated(false, completion: nil)
    }
    
}

extension ActivityChooseCityViewController :  MoyaPares {
    
    private func requestCityList() {
        ActivitySectionProvider.request(ActivitySection.CityList, completion: { [unowned self] result in
            self.showHud("正在加载")
            let resultData : Result<[Location],MyErrorType> = self.paresObjectArray(result)
            switch resultData {
            case .Success(let data):
                self.cityList = data
                self.tableView.reloadData()
                self.popHud()
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        })
    }
    
}

