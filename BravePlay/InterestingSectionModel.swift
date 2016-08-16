//
//  InterestingSectionModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

struct InterestingBanners : Mappable {
    var id: String = ""
    var title: String = ""
    var date_time: Int = 0
    var cover: String = ""
    
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        date_time <- map["date_time"]
        cover <- map["cover"]
    }
}

struct InterestingSectionDetail :  Mappable {
    
    var id : String = ""
    var date_time: Int = 0
    var is_first: String = ""
    var cover: String = ""
    var title: String = ""
    var digest: String = ""
    var author: String = ""
    var read_num: Int = 0
    
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
    }
    
}