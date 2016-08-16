//
//  ActivitySectionCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ActivitySectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customTableView: UITableView!
    var takeData: ((Void) -> (AllActivity?,HotActivity?,FreeActivity?,RoomActivity?,CourseActivity?))?
    
    private let hasPriceCellIdentifier: String = "ActivityHasPriceTableViewCell"
    private let withoutPriceCellIdentifier: String = "ActivityWithoutPriceTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initTableView()
        // Initialization code
    }

    private func initTableView() {
        customTableView.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        
        customTableView.rowHeight = 240
        customTableView.separatorStyle = .None
        customTableView.delegate = self
        customTableView.dataSource = self
        
        var nib = UINib(nibName: hasPriceCellIdentifier, bundle: nil)
        customTableView.registerNib(nib, forCellReuseIdentifier: hasPriceCellIdentifier)
        nib = UINib(nibName: withoutPriceCellIdentifier, bundle: nil)
        customTableView.registerNib(nib, forCellReuseIdentifier: withoutPriceCellIdentifier)
    }
    
}

extension ActivitySectionCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = takeData?().0 {
            return count.list.count
        } else if let count = takeData?().1 {
            return count.list.count
        } else if let count = takeData?().2 {
            return count.list.count
        } else if let count = takeData?().3 {
            return count.list.count
        } else if let count = takeData?().4 {
            return count.list.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if let count = takeData?().0 {
//            if count.list[indexPath.row].type == "10" {
//                
//            }
//        } else if let count = takeData?().1 {
//            if count.list[indexPath.row].type == "10" {
//                
//            }
//        } else if let count = takeData?().2 {
//            if count.list[indexPath.row].type == "10" {
//                
//            }
//        } else if let count = takeData?().3 {
//            if count.list[indexPath.row].type == "10" {
//                
//            }
//        } else if let count = takeData?().4 {
//            if count.list[indexPath.row].type == "10" {
//                
//            }
//        }

        guard let cell = tableView.dequeueReusableCellWithIdentifier(hasPriceCellIdentifier, forIndexPath: indexPath) as? ActivityHasPriceTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(#function)")
    }
    
}