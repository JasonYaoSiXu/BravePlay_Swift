//
//  BuyTicketView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/5.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

typealias TicketInfo = (ticketName: String, ticketRemak: String, ticketPrice: String, ticketId: String)

protocol BuyTicketViewDelegate: class {
    func tapIndex(index: Int)
}

class BuyTicketView: UIView {
    
    private var ticketInfo: [TicketInfo] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    private let tableView:UITableView = UITableView()
    private let cellIdentifier: String = "ButTicketViewTableViewCell"
    private let closeButton: UIButton = UIButton()
    private let okButton: UIButton = UIButton()
    private var custommaskView: UIView = UIView()
    private var indexPath: NSIndexPath = NSIndexPath()
    static var delegate: BuyTicketViewDelegate!
    
    init() {
        print("\(#function)")
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        custommaskView = UIView(frame: self.bounds)
        custommaskView.backgroundColor = UIColor ( red: 0.549, green: 0.3647, blue: 0.0627, alpha: 1.0 )
        custommaskView.alpha = 0.6
        addSubview(custommaskView)
        
        addSubview(tableView)
        tableView.snp.makeConstraints(closure: { [unowned self] make in
                make.top.equalTo(self.bounds.height / 4)
                make.left.equalTo(10)
                make.width.equalTo(self.bounds.size.width - 20)
                make.height.equalTo(self.bounds.size.height / 2)
        })
        tableView.backgroundColor = UIColor ( red: 0.0902, green: 0.1137, blue: 0.1333, alpha: 1.0 )
        tableView.alpha = 1.0
        tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(okButton)
        okButton.setTitle("确定", forState: .Normal)
        okButton.setTitleColor(UIColor ( red: 0.8941, green: 0.5255, blue: 0.0471, alpha: 1.0 ), forState: .Normal)
        okButton.setTitleColor(UIColor ( red: 0.3451, green: 0.3882, blue: 0.4078, alpha: 1.0 ), forState: .Disabled)
        okButton.snp.makeConstraints(closure: { [unowned self] make in
            make.top.equalTo(self.tableView.snp.bottomMargin)
            make.left.equalTo(10)
            make.width.equalTo(self.bounds.size.width - 20)
            make.height.equalTo(45)
        })
        okButton.backgroundColor = UIColor ( red: 0.0745, green: 0.0902, blue: 0.1059, alpha: 1.0 )
        okButton.enabled = false
        okButton.addTarget(self, action: #selector(BuyTicketView.tapOkButtonAction), forControlEvents: .TouchUpInside)
        
        closeButton.backgroundColor = UIColor.whiteColor()
        closeButton.layer.cornerRadius = 10
        closeButton.layer.masksToBounds = true
        addSubview(closeButton)
        closeButton.setImage(UIImage(named: "find_mw_details_del"), forState: .Normal)
        closeButton.snp.makeConstraints(closure: { [unowned self] make in
            make.right.equalTo(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(self.bounds.size.height / 4 - 20)
        })
        closeButton.addTarget(self, action: #selector(BuyTicketView.tapCloseButton), forControlEvents: .TouchUpInside)
    }
    
    private func showView() {
        guard let currentViewController = UIApplication.sharedApplication().keyWindow?.rootViewController else {
            return
        }
        self.frame = currentViewController.view.bounds
        currentViewController.view.addSubview(self)
        self.backgroundColor = UIColor.clearColor()
        currentViewController.view.bringSubviewToFront(self)
    }
    
    @objc private func tapCloseButton() {
        custommaskView.removeFromSuperview()
        tableView.removeFromSuperview()
        okButton.removeFromSuperview()
        closeButton.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    @objc private func tapOkButtonAction() {
        tapCloseButton()
        BuyTicketView.delegate.tapIndex(indexPath.row)
    }
    
    class func showBuyTicket(ticketInfo: [TicketInfo]) {
        let buyTicketView = BuyTicketView()
        buyTicketView.showView()
        buyTicketView.setUpUI()
        buyTicketView.ticketInfo = ticketInfo
    }
    
}

extension BuyTicketView :  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketInfo.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("\(#function)")
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? ButTicketViewTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath != self.indexPath {
            cell.isChoose = false
        }
        
        cell.ticketTitleLabel.text = ticketInfo[indexPath.row].ticketName
        cell.ticketInfolabel.text = ticketInfo[indexPath.row].ticketRemak
        cell.ticketPriceLabel.text = ticketInfo[indexPath.row].ticketPrice
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? ButTicketViewTableViewCell else {
            return
        }
        cell.isChoose = true
        self.indexPath = indexPath
        tableView.reloadData()
        okButton.enabled = true
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}

