//
//  MineTicketInfoCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineTicketInfoCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var ticketInfoTableView: UITableView!
    private let cellIdentifier: String = "MineTicketInfoTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        initTableView()
        // Initialization code
    }

    private func initTableView() {
        ticketInfoTableView.backgroundColor = UIColor.clearColor()
        ticketInfoTableView.delegate = self
        ticketInfoTableView.dataSource = self
        ticketInfoTableView.rowHeight = 81
        ticketInfoTableView.tableFooterView = UIView()
        ticketInfoTableView.tableHeaderView = UIView()
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        ticketInfoTableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
}

extension MineTicketInfoCollectionViewCell : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? MineTicketInfoTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
}
