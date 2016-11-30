//
//  SetModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/23.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

struct ChangeNick : Mappable {
    
    var nickname: String = ""
    var avatar: String = ""
    var telephone: String = ""
    var email: String = ""
    var sex: Int = 0
    var access_token: String = ""
    var binding_phone: Bool = false
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        nickname <- map["nickname"]
        avatar <- map["avatar"]
        telephone <- map["telephone"]
        email <- map["email"]
        sex <- map["sex"]
        access_token <- map["access_token"]
        binding_phone <- map["binding_phone"]
    }
    
}