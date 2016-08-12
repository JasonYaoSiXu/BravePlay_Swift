//
//  MainVcNetWork.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/4.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import Result

class MainVcNetWork {
    var outputPresent: MainVcConnectPresent!
    weak var outputDisplay: MainVcConnectDisplay!
}

extension MainVcNetWork : MainVcConnectRequest, MoyaPares {
    
    func requestBanner() {
        MainSectionProvider.request(MainSection.Banner) { [unowned self] result in
            let data: Result<[BannerItem], MyErrorType> = self.paresObjectArray(result)
            self.outputDisplay.displayBanner(data)
        }
    }
    
    func requestArticle() {
        MainSectionProvider.request(MainSection.Article) { [unowned self] (result) -> () in
            let data: Result<[ArticleItem], MyErrorType> = self.paresObjectArray(result)
            self.outputPresent.presentArticle(data)
        }
    }
    
    func requestActivity() {
        MainSectionProvider.request(MainSection.Activity) { [unowned self] (result) -> () in
            let data: Result<ActivityResponse, MyErrorType> = self.paresObject(result)
            self.outputPresent.presentActivity(data)
        }
    }
    
    func requestTV() {
        MainSectionProvider.request(MainSection.Tv) { [unowned self] (result) -> () in
            let data: Result<TvResponse, MyErrorType> = self.paresObject(result)
            self.outputPresent.presentTV(data)
        }
    }
    
    func requestChannel() {
        MainSectionProvider.request(MainSection.Channel) { [unowned self] (result) -> () in
            let data: Result<ChannelResponse, MyErrorType> = self.paresObject(result)
            self.outputDisplay.displayChannel(data)
        }
    }
    
    func requestTopic() {
        MainSectionProvider.request(MainSection.Topic) { [unowned self] (result) -> () in
            let data: Result<TopicResponse, MyErrorType> = self.paresObject(result)
            self.outputDisplay.displayTopic(data)
        }
    }
    
}