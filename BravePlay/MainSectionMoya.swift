//
//  MainSectionMoya.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import Moya

let mainSectionBaseUrl = "https://api.idarex.com"

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

public enum  MainSection {
    //顶部轮播图
    case Banner
    //敢玩趣闻
    case Article
    //敢玩活动
    case Activity
    //敢玩TV
    case Tv
    //自频道精选
    case Channel
    //Topic推荐
    case Topic
    //活动咨询
    case HotActivityid(id: String)
    //活动详情
    case Activitys(id: String)
    //活动视频
    case Videos(id: String)
    //视频评论
    case Barrages(id: String)
    //视频推荐
    case Recommends(id: String)
    //用户主页
    case Channels(id: String)
    //用户推荐
    case  UserRecommends(id: String)
    //用户上传视频
    case UserUpLoadVideos(id: String)
    //趣闻详情
    case ArticleDetail(id: String)
    //topic 详情
    case TopicDetai(id: String)
    //topic 推荐
    case TopicRecommends(id: String)
    //topic 视频
    case  TopicVideos(id: String)
    // 所有的channels
    case Channelsdata(page: Int)
    //所有的topics
    case TopicsData(page: Int)
}

extension MainSection :TargetType {

    public var baseURL: NSURL { return NSURL(string: mainSectionBaseUrl)! }
    public var path: String {
        switch self {
        case .Banner:
            return  "/indices"
        case .Article:
            return "/indices"
        case .Activity:
            return "/indices"
        case .Tv:
            return "/indices"
        case .Channel:
            return "/indices"
        case .Topic:
            return "/indices"
        case .HotActivityid:
            return "/questions/hot/_activityId/"
        case .Activitys:
            return "/activities/"
        case .Videos(let id):
            return "/videos/\(id)"
        case .Barrages(let id):
            return "/barrages/_videoId/\(id)"
        case .Recommends(let id):
            return "/video-recommends/\(id)"
        case .Channels:
            return "/channels/"
        case .UserRecommends:
            return "/channels/recommends/"
        case .UserUpLoadVideos:
            return "/videos/_channelId/"
        case .ArticleDetail:
            return "/wechat-articles/"
        case .TopicDetai:
            return "/topics/"
        case .TopicRecommends:
            return "/topics/recommends/"
        case .TopicVideos:
            return "/videos/_topicId/"
        case .Channelsdata:
            return "/channels"
        case .TopicsData:
            return "/topics"
        }
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
            case .Banner:
                return ["scenario":"banner"]
            case .Article:
                return ["scenario":"article","fields" : ["id","read_num","date_time","cover","title","digest","author"]]
            case .Activity:
                return ["scenario":"activity"]
            case .Tv:
                return ["scenario":"tv"]
            case .Channel:
                return ["scenario":"channel"]
            case .Topic:
                return ["scenario":"topic"]
            case .HotActivityid(let id):
                return ["":id]
            case .Activitys(let id):
                return ["":id]
            case .Videos:
                return ["expand":["topic","channel"]]
            case .Barrages:
                return ["expand":"userDetail"]
            case .Recommends:
                return ["expand":"topic"]
            case .Channels(let id):
                return ["":id]
            case .UserRecommends(let id):
                return ["":id]
            case .UserUpLoadVideos(let id):
                return ["":id,"expand":["topic","channel"],"subVersion" : "0.2"]
            case .ArticleDetail(let id):
                return ["":id]
            case .TopicDetai(let id):
                return ["":id]
            case .TopicRecommends(let id):
                return ["":id]
            case .TopicVideos(let id):
                return ["":id,"expand":["topic","channel"],"subVersion" : "0.2"]
            case .Channelsdata(let page):
                return ["expand":"videos","page":"\(page)"]
            case .TopicsData(let page):
                return ["page":"\(page)","subVersion":"0.2"]
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var sampleData: NSData {
        return "MainSection".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

public func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}

// Mark:
let endpointClosure = { (target: MainSection) -> Endpoint<MainSection> in
    let endpoint: Endpoint<MainSection> = Endpoint<MainSection>(URL: url(target),
                                                    sampleResponseClosure: {.NetworkResponse(200, target.sampleData)},
                                                    method:target.method,
                                                    parameters: target.parameters,
                                                    parameterEncoding: .URL
    )
    
    var query = ""
    
//    switch target {
//    case .Banner,.Article,.Activity,.Tv,.Channel,.Topic:
        return endpoint.endpointByAddingParameterEncoding(Moya.ParameterEncoding.Custom {
            request,parameters in
            var mutableURLRequest = request.URLRequest
            if let parameters = parameters {
                for key in parameters.keys.sort(<) {
                    let value = parameters[key]!
                    if key == "" {
                        query = query + "\(value)"
                    }
                    else if let array = value as? [AnyObject] {
                        if array.count > 1 {
                        var i = 0
                        
                        array.forEach {
                            if i == 0 {
                                if !query.isEmpty { query = query + "&" }
                                query = query + "\(key)=\($0)"
                            } else {
                                if !query.isEmpty { query = query + "," }
                                query = query + "\($0)"
                            }
                            
                            i += 1
                        }
                        
                    }
                    } else {
                        if !query.isEmpty { query = query + "&" }
                        query = query + "\(key)=\(value)"
                    }
                    
                mutableURLRequest.setValue(
                    "application/json; version=v3",
                    forHTTPHeaderField: "Accept"
                )
                let com = NSURLComponents(URL: mutableURLRequest.URL!,resolvingAgainstBaseURL:false)
                    if query.rangeOfString("=") == nil {
                        if let path = com?.percentEncodedPath {
                                com?.percentEncodedPath = path + query
                        } else {
                            com?.percentEncodedPath = query
                        }
                    } else {
                        com?.percentEncodedQuery = query
                    }
                    
                mutableURLRequest.URL = com?.URL

                }
            }
            return (mutableURLRequest,nil)
            })
//    default:
//        return endpoint
//    }
}


//let MainSectionProvider = MoyaProvider<MainSection>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
let MainSectionProvider = MoyaProvider<MainSection>(endpointClosure:endpointClosure,
    plugins: [NetworkLoggerPlugin(verbose: true,responseDataFormatter: JSONResponseDataFormatter)]
)



//                    if let array = value as? [AnyObject] {
//
//                        array.forEach {
//                            if !query.isEmpty { query = query + "&" }
//                            query = query + "\(key)=\($0)"
//                        }
//
//                    } else {
//                        if !query.isEmpty { query = query + "&" }
//                        query = query + "\(key)=\(value)"
//                    }
//                mutableURLRequest.HTTPBody =  query.URLEscapedString.dataUsingEncoding(NSUTF8StringEncoding)








