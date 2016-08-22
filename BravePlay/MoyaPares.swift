//
//  MoyaPares.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/3.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper
import Result
import Moya

protocol MoyaPares {
    func paresObject<T:Mappable>(resultResponse: Result<Moya.Response, Error>) -> Result<T, MyErrorType>
    func paresObjectArray<T:Mappable>(resultResponse: Result<Moya.Response, Error>) -> Result<[T], MyErrorType>
}

extension MoyaPares {
    
    func paresObject<T:Mappable>(resultResponse: Result<Moya.Response, Error>) -> Result<T, MyErrorType> {
        return resultResponse.flatMapError(dealError).flatMap(checkStatusCode).flatMap(toJson).flatMap(toObjectModel)
    }
    
    func paresObjectArray<T:Mappable>(resultResponse: Result<Moya.Response, Error>) -> Result<[T], MyErrorType> {
        return resultResponse.flatMapError(dealError).flatMap(checkStatusCode).flatMap(toJson).flatMap(toObjectModelArray)
    }
    
    private func dealError(error: Error) -> Result<Moya.Response, MyErrorType> {
        return .Failure(MyErrorType.NetWorkError)
    }
    
    private  func checkStatusCode(response: Moya.Response) -> Result<Moya.Response, MyErrorType> {
        if response.statusCode == 200 {
            return .Success(response)
        }
        return .Failure(MyErrorType.HttpErrorCode(code: response.statusCode))
    }
    
    private func toJson(response: Moya.Response) -> Result<AnyObject, MyErrorType> {
        do {
            return .Success(try response.mapJSON())
        } catch {
            return .Failure(MyErrorType.NoWayToParse)
        }
    }
    
    private func toObjectModel<T:Mappable>(json: AnyObject) -> Result<T, MyErrorType> {
        
        guard let resultJson = Mapper<T>().map(json) else{
            return .Failure(.NetWorkError)
        }
        
        return .Success(resultJson)
    }
    
    private func toObjectModelArray<T:Mappable>(json: AnyObject) -> Result<[T], MyErrorType> {
        
        guard let resultJson = Mapper<T>().mapArray(json) else{
            return .Failure(.NetWorkError)
        }
        
        return .Success(resultJson)
    }
    
}



/*
 
 func bannerRequest() {
 showHud("正在加载")
 MainSectionProvider.request(MainSection.Banner) { [unowned self] (result) -> () in
 switch result {
 case let .Success(response):
 do {
 let JSON = try response.mapString()
 if let data = Mapper<BannerItem>().mapArray(JSON) {
 self?.bannerRepos = data
 self?.tableViewHeadView.reloadData()
 self?.ArticleRequest()
 }
 } catch {
 self?.showInfoMessage("解析出错!")
 }
 case let .Failure(error):
 self?.showErrorMessage("\(error)")
 }
 }
 }
 
 func ArticleRequest() {
 MainSectionProvider.request(MainSection.Article) { [weak self] (result) -> () in
 switch result {
 case let .Success(response):
 do {
 let JSON = try response.mapString()
 if let data = Mapper<ArticleItem>().mapArray(JSON) {
 self?.articleRepos = data
 print("---self?.articleRepos = \(self?.articleRepos)")
 self?.ActivityRequest()
 self?.tableView.beginUpdates()
 let indexSet = NSIndexSet(index: 0)
 self?.tableView.reloadSections(indexSet, withRowAnimation: .None)
 self?.tableView.endUpdates()
 }
 } catch {
 self?.showInfoMessage("解析出错!")
 }
 case let .Failure(error):
 self?.showErrorMessage("\(error)")
 }
 }
 }
 
 func ActivityRequest() {
 MainSectionProvider.request(MainSection.Activity) { [weak self] (result) -> () in
 switch result {
 case let .Success(response):
 do {
 let JSON = try response.mapString()
 if let data = Mapper<ActivityResponse>().map(JSON) {
 self?.activityRepos = data
 self?.sectionCount.append(data.count)
 print("---self?.articleRepos = \(self?.articleRepos)")
 self?.tvRequest()
 self?.tableView.beginUpdates()
 let indexSet = NSIndexSet(index: 1)
 self?.tableView.reloadSections(indexSet, withRowAnimation: .None)
 self?.tableView.endUpdates()
 }
 } catch {
 self?.showInfoMessage("解析出错!")
 }
 case let .Failure(error):
 self?.showErrorMessage("\(error)")
 }
 }
 }
 
 func tvRequest() {
 MainSectionProvider.request(MainSection.Tv) { [weak self] (result) -> () in
 switch result {
 case let .Success(response):
 do {
 let JSON = try response.mapString()
 if let data = Mapper<TvResponse>().map(JSON) {
 self?.tvRepos = data
 self?.sectionCount.append(data.count)
 self?.channelRequest()
 self?.tableView.beginUpdates()
 let indexSet = NSIndexSet(index: 2)
 self?.tableView.reloadSections(indexSet, withRowAnimation: .None)
 self?.tableView.endUpdates()
 }
 } catch {
 self?.showInfoMessage("解析出错!")
 }
 case let .Failure(error):
 self?.showErrorMessage("\(error)")
 }
 }
 }
 
 func channelRequest() {
 MainSectionProvider.request(MainSection.Channel) { [weak self] (result) -> () in
 switch result {
 case let .Success(response):
 do {
 let JSON = try response.mapString()
 if let data = Mapper<ChannelResponse>().map(JSON) {
 self?.channelRepos = data
 self?.sectionCount.append(data.count)
 self?.topicRequest()
 self?.tableView.beginUpdates()
 let indexSet = NSIndexSet(index: 3)
 self?.tableView.reloadSections(indexSet, withRowAnimation: .None)
 self?.tableView.endUpdates()
 }
 } catch {
 self?.showInfoMessage("解析出错!")
 }
 case let .Failure(error):
 self?.showErrorMessage("\(error)")
 }
 }
 }
 
 func topicRequest() {
 MainSectionProvider.request(MainSection.Topic) { [weak self] (result) -> () in
 switch result {
 case let .Success(response):
 do {
 let JSON = try response.mapString()
 if let data = Mapper<TopicResponse>().map(JSON) {
 self?.topicRepos = data
 self?.sectionCount.append(data.count)
 self?.popHud()
 self?.tableView.beginUpdates()
 let indexSet = NSIndexSet(index: 4)
 self?.tableView.reloadSections(indexSet, withRowAnimation: .None)
 self?.tableView.endUpdates()
 }
 } catch {
 self?.showInfoMessage("解析出错!")
 }
 case let .Failure(error):
 self?.showErrorMessage("\(error)")
 }
 }
 }

 
 */


