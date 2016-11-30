//
//  MainVcPresentData.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/4.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import Result

class MainVcPresentData {
    weak var outputDisplay: MainVcConnectDisplay!
}

extension MainVcPresentData : MainVcConnectPresent {
    
    func presentArticle(presentData: Result<[ArticleItem], MyErrorType>) {
        var displayData : [ArticleItem]?
        var errorMessage: MyErrorType?
        
        switch presentData {
        case .Success(let responseData):
            var displayDataArray: [ArticleItem] = []
            responseData.forEach({
                var item = ArticleItem()
                item = $0
                let seconds = item.date_time
                let date = NSDate(timeIntervalSince1970: Double(seconds))
                let dateFormat = NSDateFormatter()
                dateFormat.dateFormat = "MM-dd"
                let dateStr = dateFormat.stringFromDate(date)
                item.author = item.author + " | " + dateStr
                displayDataArray.append(item)
            })
            displayData = displayDataArray
        case .Failure(let error):
            errorMessage = error
        }
        
        outputDisplay.displayArticle(displayData, error: errorMessage)
    }
    
    func presentActivity(presentData: Result<ActivityResponse, MyErrorType>) {
        var displayData : ActivityResponse?
        var errorMessage: MyErrorType?
        
        switch presentData {
        case .Success(let responseData):
            var displayDataArray: ActivityResponse = ActivityResponse()
            displayDataArray.activityItem.removeAll()
            responseData.activityItem.forEach({
                var item = $0
                if let seconds = Int(item.time) {
                    let date = NSDate(timeIntervalSince1970: Double(seconds))
                    let dateFormat = NSDateFormatter()
                    dateFormat.dateFormat = "MM-dd"
                    let dateStr = dateFormat.stringFromDate(date)
                    item.s_location = item.s_location + " | " + dateStr
                }
                item.expense = "¥" + item.expense
                displayDataArray.activityItem.append(item)
            })
            displayDataArray.count = responseData.count
            displayData = displayDataArray
        case .Failure(let error):
            errorMessage = error
        }
        outputDisplay.displayActivity(displayData, error: errorMessage)
    }
    
    func presentTV(presentData: Result<TvResponse, MyErrorType>) {
        var displayData : TvResponse?
        var errorMessage: MyErrorType?

        switch presentData {
        case .Success(let response):
            var displayDataArray: TvResponse = TvResponse()
            displayDataArray.tvItem.removeAll()
            response.tvItem.forEach({
                var item = $0
                if let second = Int(item.duration) {
                    let munites = second / 60
                    let seconds = second % 60
                    item.name = item.name + "  \(munites)'\(seconds)"
                }
                displayDataArray.tvItem.append(item)
            })
            displayDataArray.count = response.count
            displayData = displayDataArray
        case .Failure(let error):
            errorMessage = error
        }
        outputDisplay.displayTV(displayData, error: errorMessage)
    }
    
}