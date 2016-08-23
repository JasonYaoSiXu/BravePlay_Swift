//
//  MineCareCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol   MineCareCollectionViewCellDelegate : class {
    func tapWitchCellItem(indexModel: Int, index: Int)
    func tapLastCellItem(index: Int)
}

class MineCareCollectionViewCell: UICollectionViewCell {

    var takeDate : ((Void) -> UserCareList)?
    
    @IBOutlet weak var careTableView: UITableView!
    private let cellIdentifier: String = "MineCareTableViewCell"
    weak var deleagte : MineCareCollectionViewCellDelegate!
    
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
        if takeDate == nil {
            return 0
        }
        return takeDate!().models.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? MineCareTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.takeData = { [unowned self] _ in
            return (self.takeDate!().models[indexPath.row], indexPath.row)
        }
        
        cell.headImageView.setImageWithURL(makeImageURL(takeDate!().models[indexPath.row].avatar), defaultImage: UIImage(named: "find_mw_bg"))
        cell.typeLabel.text = takeDate!().models[indexPath.row].name
        
        cell.customCollectionView.reloadData()
        return cell
    }
    
}

extension MineCareCollectionViewCell : MineCareTableViewCellDelegate {
    
    func tapCareCell(indexModel: Int, index: Int) {
        deleagte.tapWitchCellItem(indexModel, index: index)
    }
    
    func tapCareCellIsLast(index: Int) {
        deleagte.tapLastCellItem(index)
    }
    
}

