//
//  StoryBoardMoya.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/23.
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

public enum  StorySection {
    //注册页面获取验证码
    case RegisterGetCheckCode(phone_number: String)
    //注册
    case Register(nickname: String,password: String,phone_number: String,verify_code: String)
    //忘记密码获取验证码
    case ForgetPassword(phone_number: String)
    //修改密码  password=22222222&phone_number=15877347757&verify_code=236197  https://api.idarex.com/reset-passwords?scenario=phone_number
    case ChangePassword(password: String,phone_number: String,verify_code: String)
}

extension StorySection :TargetType {
    
    public var baseURL: NSURL { return NSURL(string: mainSectionBaseUrl)! }
    public var path: String {
        switch self {
        case .RegisterGetCheckCode:
            return "/phone-verify-codes?scenario=signup"
        case .Register:
            return "/users?scenario=phone_number"
        case .ForgetPassword:
            return "/phone-verify-codes?scenario=forget-password"
        case .ChangePassword:
            return "/reset-passwords?scenario=phone_number"
        }
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .RegisterGetCheckCode(let phoneNum):
            return ["phone_number":phoneNum]
        case .Register(let nickname, let password,let phone_number,let verify_code):
            return ["nickname":nickname, "password" : password,"phone_number":phone_number,"verify_code":verify_code]
        case .ForgetPassword(let phone_number):
            return ["phone_number" : phone_number]
        case .ChangePassword(let password,let phone_number,let verify_code):
            return ["password":password,"phone_number":phone_number,"verify_code":verify_code]
        }
    }
    
    public var method: Moya.Method {
        switch   self {
        case .RegisterGetCheckCode,.Register,.ForgetPassword,.ChangePassword:
            return .POST
        default:
            return .GET
        }
    }
    
    public var sampleData: NSData {
        return "MainSection".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

let storyEndpointClosure = { (target: StorySection) -> Endpoint<StorySection> in
    let endpoint: Endpoint<StorySection> = Endpoint<StorySection>(URL: url(target),
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
                case .RegisterGetCheckCode:
                    let body = query
                    let data = body.dataUsingEncoding(NSUTF8StringEncoding)
                    mutableURLRequest.HTTPBody = data
                    let logSectionBaseUrl = "https://api.idarex.com/phone-verify-codes?scenario=signup"
                    let url = NSURL(string: logSectionBaseUrl)
                    mutableURLRequest.URL = url
                case .Register:
                    let body = query
                    let data = body.dataUsingEncoding(NSUTF8StringEncoding)
                    mutableURLRequest.HTTPBody = data
                    let logSectionBaseUrl = "https://api.idarex.com/users?scenario=phone_number"
                    let url = NSURL(string: logSectionBaseUrl)
                    mutableURLRequest.URL = url
                case .ForgetPassword:
                    let body = query
                    let data = body.dataUsingEncoding(NSUTF8StringEncoding)
                    mutableURLRequest.HTTPBody = data
                    let logSectionBaseUrl = "https://api.idarex.com/phone-verify-codes?scenario=forget-password"
                    let url = NSURL(string: logSectionBaseUrl)
                    mutableURLRequest.URL = url
                case .ChangePassword:
                    let body = query
                    let data = body.dataUsingEncoding(NSUTF8StringEncoding)
                    mutableURLRequest.HTTPBody = data
                    let logSectionBaseUrl = "https://api.idarex.com/reset-passwords?scenario=phone_number"
                    let url = NSURL(string: logSectionBaseUrl)
                    mutableURLRequest.URL = url
                }
            }
        }
        
        return (mutableURLRequest,nil)
        })
}


let storySectionProvider = MoyaProvider<StorySection>(endpointClosure:storyEndpointClosure,
                                                    plugins: [NetworkLoggerPlugin(verbose: true,responseDataFormatter: JSONResponseDataFormatter)]
)