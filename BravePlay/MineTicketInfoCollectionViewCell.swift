//
//  MineTicketInfoCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineTicketInfoCollectionViewCell: UICollectionViewCell {

    var takeData : ((Void) -> [UserMessage])?
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
        if takeData == nil {
            return 0
        }
        return takeData!().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? MineTicketInfoTableViewCell else {
            return UITableViewCell()
        }
                
        cell.headImageView.setImageWithURL(makeImageURL(takeData!()[indexPath.row].sender.avatar), defaultImage: UIImage(named: "find_mw_bg"))
        cell.timeLabel.text = takeData!()[indexPath.row].sender.nickname + " 回复了您的咨询:"
        cell.infoLabel.text = takeData!()[indexPath.row].notification.content
        cell.timeLabel.text = takeData!()[indexPath.row].created_at
        
        return cell
    }
    
}
