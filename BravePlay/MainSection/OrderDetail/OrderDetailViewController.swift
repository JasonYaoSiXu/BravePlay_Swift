//
//  OrderDetailViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/5.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

//订单详情
import UIKit

class OrderDetailViewController: UIViewController {

    private var activityId: String = ""
    private var ticketId: String = ""
    private var ticketPrice: String = ""
    private let height : CGFloat = 50
    private let priceLabel = UILabel()
    private let joinButton = UIButton(type: UIButtonType.Custom)
    private let tableView = UITableView()
    private var ticketNumbers: Int = 0
    private var chooseType: Int = -1
    private var index: NSIndexPath = NSIndexPath()
    
    private let titleCellIdentifier = "OrderDetailCellTitleTableViewCell"
    private let contactCellIdentifier = "OrderDetailContactTableViewCell"
    private let orderDetailIdentifierFirstRow = "OrderDetailTableViewCell"
    private let orderDetailIdentifierSecondRow = "OrderDetailTicketNumberTableViewCell"
    private let payWayCellIdentifier = "OrderDetailPayWaysTableViewCell"
    private let titleArray: [String] = ["联系人信息","订单信息","支付方式"]
    private let titleInfoArray: [String] = ["姓名","手机","工作单位","报名来源","课程选择"]
    private let placeholderInfoArray: [String] = ["请填写联系人姓名","填写手机号方便联系","必填","必填","必填"]
    
    init(activityId: String, ticketId: String,ticketPrice: String) {
        self.activityId = activityId
        self.ticketId = ticketId
        self.ticketPrice = ticketPrice
        super.init(nibName: nil, bundle: nil)
        print("activityId = \(activityId),ticketId = \(ticketId),ticketPrice = \(ticketPrice)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor ( red: 0.2157, green: 0.3098, blue: 0.3255, alpha: 1.0 )
        setTableView()
        setUI()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 1
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "订单详情"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        joinButton.addTarget(self, action: #selector(OrderDetailViewController.tapJoinButton), forControlEvents: .TouchUpInside)
    }
    
    private func setTableView() {
        tableView.frame = CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height - 110)
        view.addSubview(tableView)
        
        tableView.separatorStyle = .SingleLineEtched
        var nib = UINib(nibName: titleCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: titleCellIdentifier)
        nib = UINib(nibName: contactCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: contactCellIdentifier)
        nib = UINib(nibName: orderDetailIdentifierFirstRow, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: orderDetailIdentifierFirstRow)
        nib = UINib(nibName: orderDetailIdentifierSecondRow, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: orderDetailIdentifierSecondRow)
        nib = UINib(nibName: payWayCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: payWayCellIdentifier)
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func tapJoinButton() {
        
        let pathArray = [NSIndexPath(forRow: 1, inSection: 0),NSIndexPath(forRow: 2, inSection: 0),NSIndexPath(forRow: 3, inSection: 0),NSIndexPath(forRow: 4, inSection: 0),NSIndexPath(forRow: 5, inSection: 0)]
        var i = 0
        pathArray.forEach({ [unowned self]  in
            guard let cells = self.tableView.cellForRowAtIndexPath($0) as? OrderDetailContactTableViewCell else {
                return
            }
            if cells.promptTextField.text != "" {
                i += 1
            }
        })
        
        if pathArray.count != i {
            showInfoMessage("请填写个人信息")
            return
        }
        
        if chooseType == -1 {
            showInfoMessage("请选择付款方式")
            return
        } else if chooseType == 1 {
            
        } else if chooseType == 2 {
            
        }
        print("\(#function)choosType = \(chooseType)")
    }
    
}

extension OrderDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 6
        case 1:
            return 3
        default:
            return 3
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("\(#function)")
        
        switch (indexPath.section, indexPath.row) {
        case (_, 0):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(titleCellIdentifier, forIndexPath: indexPath) as? OrderDetailCellTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.remarksLabel.text = titleArray[indexPath.section]
            if indexPath.section == 0 {
                cell.titleLabel.hidden = false
            }
            return cell
        case (0, _):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(contactCellIdentifier, forIndexPath: indexPath) as? OrderDetailContactTableViewCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = titleInfoArray[indexPath.row - 1]
            cell.promptTextField.placeholder = placeholderInfoArray[indexPath.row -  1]
            return cell
        case (1, _):
            if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCellWithIdentifier(orderDetailIdentifierFirstRow, forIndexPath: indexPath) as? OrderDetailTableViewCell else {
                    return UITableViewCell()
                }
                cell.pricelabel.text = ticketPrice
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCellWithIdentifier(orderDetailIdentifierSecondRow, forIndexPath: indexPath) as? OrderDetailTicketNumberTableViewCell else {
                    return UITableViewCell()
                }
                cell.chooseView!.delegate = self
                return cell
            }
        case (2, _):
            guard let cell = tableView.dequeueReusableCellWithIdentifier(payWayCellIdentifier, forIndexPath: indexPath) as? OrderDetailPayWaysTableViewCell else {
                return UITableViewCell()
            }
            
            if indexPath != index {
                cell.isSeleted = false
            } else {
                cell.isSeleted = true
                //1 微信 2 支付宝
                chooseType = indexPath.row
            }
            
            if indexPath.row == 1 {
                cell.payWayImageView.image = UIImage(named: "wechat")
                cell.payNameLabel.text = "微信支付"
            } else {
                cell.payWayImageView.image = UIImage(named: "ali")
                cell.payNameLabel.text = "支付宝支付"
            }
            
            return cell
        default:
            print("default")
            return UITableViewCell()
        }
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.backgroundColor = UIColor.clearColor()
        return headView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 2 {
            index = indexPath
            reloadTableViewOf(indexPath)
        }
    }
    
    func reloadTableViewOf(index: NSIndexPath) {
        tableView.beginUpdates()
        let indexSet = NSIndexSet(index: index.section)
        tableView.reloadSections(indexSet, withRowAnimation: .None)
        tableView.endUpdates()
    }
    
}

extension OrderDetailViewController : NumberOfTicketsViewDelegate {
    
    func ticketNumbers(numbers: Int) {
        ticketNumbers = numbers
        guard let price = Int(ticketPrice) else {
            return
        }
        priceLabel.text = "¥\(numbers * price)"
    }
}