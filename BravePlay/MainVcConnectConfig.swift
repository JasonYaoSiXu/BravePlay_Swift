//
//  MainVcConnectConfig.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/4.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import Result

protocol  MainVcConnectRequest {
    ///轮播图
    func requestBanner()
    ///敢玩趣闻
    func requestArticle()
    ///敢玩活动
    func requestActivity()
    ///敢玩tv
    func requestTV()
    ///精选推荐
    func requestChannel()
    ///topic推荐
    func requestTopic()
}

protocol MainVcConnectPresent {
    ///敢玩趣闻
    func presentArticle(presentData: Result<[ArticleItem], MyErrorType>)
    ///敢玩活动
    func presentActivity(presentData: Result<ActivityResponse, MyErrorType>)
    ///敢玩tv
    func presentTV(presentData: Result<TvResponse, MyErrorType>)
}

protocol MainVcConnectDisplay : class  {
    ///轮播图
    func displayBanner(displayData: Result<[BannerItem], MyErrorType>)
    
    ///敢玩趣闻
    func displayArticle(displayData: [ArticleItem]?, error: MyErrorType?)
    ///敢玩活动
    func displayActivity(displayData: ActivityResponse?,error: MyErrorType?)
    ///敢玩tv
    func displayTV(displayData: TvResponse?,error: MyErrorType?)
    
    ///精选推荐
    func displayChannel(displayData: Result<ChannelResponse, MyErrorType>)
    ///topic推荐
    func displayTopic(displayData: Result<TopicResponse, MyErrorType>)
}



