//
//  TopicsModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/24.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

struct TopicsModel : Mappable {
    
    var id: Int = 0
    var avatar: String = ""
    var headimg: String = ""
    var name: String = ""
    var recommend_normal_image: String = ""
    var recommend_hover_image: String = ""
    var recommend_background_image: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        avatar <- map["avatar"]
        headimg <- map["headimg"]
        name <- map["name"]
        recommend_normal_image <- map["recommend_normal_image"]
        recommend_hover_image <- map["recommend_hover_image"]
        recommend_background_image <- map["recommend_background_image"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}
