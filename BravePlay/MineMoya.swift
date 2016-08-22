//
//  MineMoya.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/22.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import Moya

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

public enum  MineSection {
    //登录
    case Sessions(password: String, phoneNumber: String)
    //用户信息
    case  UserData(userToken: String)
    //未读消息
    case  UnReadCount(userToken: String)
    //系统消息
    case SystemMessage(page: Int)
    //关注列表
    case CareList
    //喜欢列表
    case LikeList(page: Int)
}

extension MineSection :TargetType {
    
    public var baseURL: NSURL { return NSURL(string: mainSectionBaseUrl)! }
    public var path: String {
        switch self {
        case .Sessions:
            return "/sessions?scenario=phone_number"
        case .UserData:
            return "/users/_current?expand=favorite_video,subscribe_channel,subscribe_topic,favorite_activity"
        case .UnReadCount:
            return "/notifications/unread-count"
        case .SystemMessage:
            return "/notifications"
        case .CareList:
            return "/subscribes"
        case .LikeList:
            return "/video-favorites"
        }
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .Sessions(let password, let phoneNumber):
            return ["password":password, "phone_number": phoneNumber]
        case .UserData(let token):
            return ["": token]
        case .UnReadCount(let token):
            return ["": token]
        case .SystemMessage(let page):
            return ["page": "\(page)"]
        case .CareList:
            return ["":""]
        case .LikeList(let page):
            return ["page" : "\(page)","expand" : ["video","topic"]]
        }
    }
    
    public var method: Moya.Method {
        switch   self {
        case .Sessions:
            return .POST
        default:
            return .GET
        }
    }
    
    public var sampleData: NSData {
        return "MainSection".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

let mineEndpointClosure = { (target: MineSection) -> Endpoint<MineSection> in
    let endpoint: Endpoint<MineSection> = Endpoint<MineSection>(URL: url(target),
                                                            sampleResponseClosure: {.NetworkResponse(200, target.sampleData)},
                                                            method:target.method,
                                                            parameters: target.parameters,
                                                            parameterEncoding: .URL
    )
    
    var query = ""
    
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
                
                switch target {
                case .Sessions:
                    let body = query
                    let data = body.dataUsingEncoding(NSUTF8StringEncoding)
                    mutableURLRequest.HTTPBody = data
                    let logSectionBaseUrl = "https://api.idarex.com/sessions?scenario=phone_number"
                    let url = NSURL(string: logSectionBaseUrl)
                    mutableURLRequest.URL = url
                case .UserData:
                    let dataUrl = "https://api.idarex.com/users/_current?expand=favorite_video,subscribe_channel,subscribe_topic,favorite_activity"
                    let url = NSURL(string: dataUrl)
                    mutableURLRequest.URL = url
                    mutableURLRequest.setValue(
                        "Bearer  \(query)",
                        forHTTPHeaderField: "Authorization"
                    )
                case .UnReadCount:
                    let dataUrl = "https://api.idarex.com/notifications/unread-count"
                    let url = NSURL(string: dataUrl)
                    mutableURLRequest.URL = url
                    mutableURLRequest.setValue(
                        "Bearer  \(query)",
                        forHTTPHeaderField: "Authorization"
                    )
                case .LikeList:
                    mutableURLRequest.setValue(
                        "Bearer  \(UserData.UserDatas.access_token!)",
                        forHTTPHeaderField: "Authorization"
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
                default:
                    mutableURLRequest.setValue(
                        "Bearer  \(UserData.UserDatas.access_token!)",
                        forHTTPHeaderField: "Authorization"
                    )
                }
            }
        }
        
        return (mutableURLRequest,nil)
        })
}


let mineSectionProvider = MoyaProvider<MineSection>(endpointClosure:mineEndpointClosure,
                                                plugins: [NetworkLoggerPlugin(verbose: true,responseDataFormatter: JSONResponseDataFormatter)]
)