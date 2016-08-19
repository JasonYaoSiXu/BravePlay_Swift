//
//  MineLikeCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MineLikeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var custonTableView: UITableView!
    
    private let tvCellIdentifier: String = "UserCustomTableViewCell"
    private let activityCellIdentifier: String = "ActivityHasPriceTableViewCell"
    
    private var selectedIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        setSegmentControl()
        initTableView()
    }
    
    private func setSegmentControl() {
        segmentControl.tintColor = UIColor ( red: 0.349, green: 0.4235, blue: 0.4588, alpha: 1.0 )
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName :  UIColor.whiteColor()], forState: .Normal)
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName :  UIColor.whiteColor()], forState: .Selected)
        segmentControl.selectedSegmentIndex = 0
        selectedIndex = segmentControl.selectedSegmentIndex
    }
    
    @IBAction func tapSegmentControl(sender: UISegmentedControl) {
        print("\(#function):: \(sender.selectedSegmentIndex)")
        selectedIndex = sender.selectedSegmentIndex
        custonTableView.reloadData()
    }

    private func initTableView() {
        custonTableView.backgroundColor = UIColor ( red: 0.2353, green: 0.3333, blue: 0.3451, alpha: 1.0 )
        custonTableView.tableFooterView = UIView()
        custonTableView.separatorStyle = .None
        custonTableView.delegate = self
        custonTableView.dataSource = self
        
        var nib = UINib(nibName: tvCellIdentifier, bundle: nil)
        custonTableView.registerNib(nib, forCellReuseIdentifier: tvCellIdentifier)
        nib = UINib(nibName: activityCellIdentifier, bundle: nil)
        custonTableView.registerNib(nib, forCellReuseIdentifier: activityCellIdentifier)
    }
    
}

extension MineLikeCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if selectedIndex == 0 {
            guard let cell = tableView.dequeueReusableCellWithIdentifier(tvCellIdentifier, forIndexPath: indexPath) as? UserCustomTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCellWithIdentifier(activityCellIdentifier, forIndexPath: indexPath) as? ActivityHasPriceTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedIndex == 0 {
            return 280
        } else {
            return 240
        }
    }
    
}
