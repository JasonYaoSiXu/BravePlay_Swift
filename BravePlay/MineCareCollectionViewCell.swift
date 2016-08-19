//
//  MineCareCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineCareCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var careTableView: UITableView!
    private let cellIdentifier: String = "MineCareTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        initTableView()
        // Initialization code
    }

    private func initTableView() {
        careTableView.backgroundColor = UIColor.clearColor()
        careTableView.rowHeight = 151
        careTableView.tableFooterView = UIView()
        careTableView.separatorStyle = .None
        careTableView.delegate = self
        careTableView.dataSource = self
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        careTableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
}

extension MineCareCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? MineCareTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
}
