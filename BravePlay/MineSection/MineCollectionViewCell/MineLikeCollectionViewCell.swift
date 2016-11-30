//
//  MineLikeCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/17.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol  MineLikeCollectionViewCellDelegate : class {
    func tapCellItem(whitchOther: Int, userLike: UserLike?, userLikeActivity: UserLikeActivity?)
}

class MineLikeCollectionViewCell: UICollectionViewCell {

    var takeData : ((Void) -> ([UserLike],[UserLikeActivity]))?
    weak var delegate : MineLikeCollectionViewCellDelegate!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var custonTableView: UITableView!
    
    private let tvCellIdentifier: String = "UserCustomTableViewCell"
    private let activityCellIdentifier: String = "ActivityHasPriceTableViewCell"
    
    private var selectedIndex: Int = 0 {
        didSet {
            custonTableView.reloadData()
        }
    }
    
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
        // selectedIndex == 0  TV  selectedIndex == 1 活动
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
        if takeData == nil {
            return 0
        } else if selectedIndex == 0 {
            return takeData!().0.count
        } else {
            return takeData!().1.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if selectedIndex == 0 {
            guard let cell = tableView.dequeueReusableCellWithIdentifier(tvCellIdentifier, forIndexPath: indexPath) as? UserCustomTableViewCell else {
                return UITableViewCell()
            }
            cell.coverImageView.setImageWithURL(makeImageURL(takeData!().0[indexPath.row].video.front_cover), defaultImage: UIImage(named: "find_mw_bg"))
            cell.titleLabel.text = takeData!().0[indexPath.row].video.title
            cell.nameLabel.text = takeData!().0[indexPath.row].topic.name
            cell.timeInfoLabel.text = caculateTimeLengthString(takeData!().0[indexPath.row].video.duration)
            cell.timeLabel.text = caculateDateString(takeData!().0[indexPath.row].video.created_at)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCellWithIdentifier(activityCellIdentifier, forIndexPath: indexPath) as? ActivityHasPriceTableViewCell else {
                return UITableViewCell()
            }

            cell.coverImageView.setImageWithURL(makeImageURL(takeData!().1[indexPath.row].activity.avatar), defaultImage: UIImage(named: "find_mw_bg"))
            cell.titleLabel.text = takeData!().1[indexPath.row].activity.title
            cell.addressLabel.text = takeData!().1[indexPath.row].activity.s_location
            cell.priceLabel.text = "¥ \(takeData!().1[indexPath.row].activity.expense)"
            cell.timeLabel.text = caculateDateString(takeData!().1[indexPath.row].activity.created_at)
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate.tapCellItem(selectedIndex, userLike: takeData!().0[indexPath.row], userLikeActivity: takeData!().1[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedIndex == 0 {
            return 280
        } else {
            return 240
        }
    }
    
    private func caculateTimeLengthString(timeLength: Int) -> String {
        let mintues = timeLength / 60
        let seconds = timeLength % 60
        return "\(mintues)'\(seconds)"
    }
    
    private func caculateDateString(sourceDate: Int) -> String {
        let date = Double(sourceDate)
        let day = NSDate(timeIntervalSince1970: date)
        let dateFormat = NSDateFormatter()
        
        if selectedIndex == 0 {
            dateFormat.dateFormat = "MM-dd"
        } else {
            dateFormat.dateFormat = "MM月dd日"
        }
        
        return dateFormat.stringFromDate(day)
    }
    
}
