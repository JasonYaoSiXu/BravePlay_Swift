//
//  InterestingModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/15.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper


struct InterestingResponse : Mappable {
    
    var id: String = ""
    var date_time: Int = 0
    var is_first: String = ""
    var cover: String = ""
    var title: String = ""
    var digest: String = ""
    var author: String = ""
    var read_num: String = ""
    var detail: InterestingDetail = InterestingDetail()
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        date_time <- map["date_time"]
        is_first <- map["is_first"]
        cover <- map["cover"]
        title <- map["title"]
        digest <- map["digest"]
        author <- map["author"]
        read_num <- map["read_num"]
        detail <- map["detail"]
    }
    
}

struct InterestingDetail : Mappable {
    var content_url: String = ""
    var content: String = ""
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        content_url <- map["content_url"]
        content <- map["content"]
    }
    
}