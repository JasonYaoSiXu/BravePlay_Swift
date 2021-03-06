//
//  InterestingMoya.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
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

public enum  IntersetingSection {
    //轮播
    case Banners
    //趣闻内容
    case InterestDetail(page: Int)
}

extension IntersetingSection :TargetType {
    
    public var baseURL: NSURL { return NSURL(string: mainSectionBaseUrl)! }
    public var path: String {
        switch self {
        case .Banners:
            return "/wechat-article-banners"
        case .InterestDetail:
            return "/wechat-articles"
        }
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .Banners:
            return ["":""]
        case .InterestDetail(let page):
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

let interestingEndpointClosure = { (target: IntersetingSection) -> Endpoint<IntersetingSection> in
    let endpoint: Endpoint<IntersetingSection> = Endpoint<IntersetingSection>(URL: url(target),
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
}


let IntersetingSectionProvider = MoyaProvider<IntersetingSection>(endpointClosure:interestingEndpointClosure,
                                                    plugins: [NetworkLoggerPlugin(verbose: true,responseDataFormatter: JSONResponseDataFormatter)]
)








