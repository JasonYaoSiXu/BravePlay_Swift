//
//  StoryBoardModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/23.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

//注册获取验证码
struct RegisterCheckCode : Mappable {
    
    var rateLimitSeconds: Int = 0
    var verifyCodeTtl: Int = 0
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        rateLimitSeconds <- map["rateLimitSeconds"]
        verifyCodeTtl <- map["verifyCodeTtl"]
    }
    
}

//获取验证码失败
struct GetRegisterCheckCodeError : Mappable {
    
    var field : String = ""
    var message: String = ""
    
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        field <- map["field"]
        message <- map["message"]
    }
    
}