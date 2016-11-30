//
//  ActivitySectionCollectionViewCell.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol ActivitySectionCollectionViewCellDelegate: class {
    func tapTableViewCell(rankList: RankList)
}


class ActivitySectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customTableView: UITableView!
    var takeData: ((Void) -> (AllActivity?,HotActivity?,FreeActivity?,RoomActivity?,CourseActivity?))?
    private var resultData : ResultData = ResultData()
    
    private let hasPriceCellIdentifier: String = "ActivityHasPriceTableViewCell"
    private let withoutPriceCellIdentifier: String = "ActivityWithoutPriceTableViewCell"
    
    weak var delegate: ActivitySectionCollectionViewCellDelegate!
    
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
            resultData.currentPage = count.currentPage
            resultData.pageCount = count.pageCount
            resultData.rankList = count.list
        } else if let count = takeData?().1 {
            resultData.currentPage = count.currentPage
            resultData.pageCount = count.pageCount
            resultData.rankList = count.list
        } else if let count = takeData?().2 {
            resultData.currentPage = count.currentPage
            resultData.pageCount = count.pageCount
            resultData.rankList = count.list
        } else if let count = takeData?().3 {
            resultData.currentPage = count.currentPage
            resultData.pageCount = count.pageCount
            resultData.rankList = count.list
        } else if let count = takeData?().4 {
            resultData.currentPage = count.currentPage
            resultData.pageCount = count.pageCount
            resultData.rankList = count.list
        }
        
        return resultData.rankList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // type == "10" 有售价  type == "9" 无售价
        
        if resultData.rankList.count > 0  {
            if resultData.rankList[indexPath.row].type == "10" {
                guard let cell = hasPriceCell(tableView, cellIdentifier: hasPriceCellIdentifier, indexPath: indexPath,result: resultData) else {
                    return UITableViewCell()
                }
                return cell
            } else if resultData.rankList[indexPath.row].type == "9" {
                guard let cell = withoutPriceCell(tableView, cellIdentifier: withoutPriceCellIdentifier, indexPath: indexPath,result: resultData) else {
                    return UITableViewCell()
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate.tapTableViewCell(resultData.rankList[indexPath.row])
    }
    
    
    private func hasPriceCell(tableView: UITableView, cellIdentifier: String, indexPath: NSIndexPath,result: ResultData) -> ActivityHasPriceTableViewCell? {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(hasPriceCellIdentifier, forIndexPath: indexPath) as? ActivityHasPriceTableViewCell else {
            return nil
        }
        
        if let seconds = Double(result.rankList[indexPath.row].time) {
            let date = NSDate(timeIntervalSince1970: seconds)
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "MM月dd日"
            let dateStr = dateFormat.stringFromDate(date)
            cell.timeLabel.text = dateStr
        }

        cell.titleLabel.text = result.rankList[indexPath.row].title
        cell.addressLabel.text = result.rankList[indexPath.row].s_location
        cell.priceLabel.text = "¥" + result.rankList[indexPath.row].expense
        cell.coverImageView.setImageWithURL(makeImageURL(result.rankList[indexPath.row].avatar), defaultImage: UIImage(named: "find_mw_bg"))
        
        return cell
    }
    
    
    private func withoutPriceCell(tableView: UITableView, cellIdentifier: String, indexPath: NSIndexPath,result: ResultData) -> ActivityWithoutPriceTableViewCell? {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(withoutPriceCellIdentifier, forIndexPath: indexPath) as? ActivityWithoutPriceTableViewCell else {
            return nil
        }
        
        cell.titleLabel.text = result.rankList[indexPath.row].title
        cell.addressLabel.text = result.rankList[indexPath.row].s_location
        cell.timeLabel.text = result.rankList[indexPath.row].date_limited_for_longtime
        cell.bgImageView.setImageWithURL(makeImageURL(result.rankList[indexPath.row].avatar), defaultImage: UIImage(named: "find_mw_bg"))
        
        return cell
    }
    
}