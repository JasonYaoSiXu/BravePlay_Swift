//
//  TVSectionModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

struct TVSectionResponse : Mappable {
    
    var id: Int = 0
    var title: String = ""
    var channel_id: Int = 0
    var topic_id: Int = 0
    var duration: Int = 0
    var front_cover: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var topic: TVSectionTopic = TVSectionTopic()
    var channel: TVSectionChannel = TVSectionChannel()
    
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        channel_id <- map["channel_id"]
        topic_id <- map["topic_id"]
        duration <- map["duration"]
        front_cover <- map["front_cover"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        topic <- map["topic"]
        channel <- map["channel"]
    }
    
}

struct TVSectionTopic: Mappable {
    
    var id: Int = 0
    var name: String = ""
    var avatar: String = ""
    var headimg: String = ""
    var recommend_normal_image: String = ""
    var recommend_hover_image: String = ""
    var recommend_background_image: String = ""
    var subscribe: Int = 0
    var created_at: Int = 0
    var updated_at: Int = 0
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        headimg <- map["headimg"]
        recommend_normal_image <- map["recommend_normal_image"]
        recommend_hover_image <- map["recommend_hover_image"]
        recommend_background_image <- map["recommend_background_image"]
        subscribe <- map["subscribe"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}

struct TVSectionChannel: Mappable {
    
    var id: Int = 0
    var name: String = ""
    var type: Int = 0
    var avatar: String = ""
    var url: String = ""
    var description: String = ""
    var subscribe: Int = 0
    var headimg: String = ""
    var pc_headimg: String = ""
    var video_sum: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        avatar <- map["avatar"]
        url <- map["url"]
        description <- map["description"]
        subscribe <- map["subscribe"]
        headimg <- map["headimg"]
        pc_headimg <- map["pc_headimg"]
        video_sum <- map["video_sum"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}