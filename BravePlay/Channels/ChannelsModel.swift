//
//  ChannelsModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/24.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

struct ChannelsData : Mappable {
    
    var id: Int = 0
    var name: String = ""
    var type: Int = 0
    var avatar: String = ""
    var url: String = ""
    var description: String = ""
    var headimg: String = ""
    var pc_headimg: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var videos: [ChannelsDataVideos] = []
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        avatar <- map["avatar"]
        url <- map["url"]
        description <- map["description"]
        videos <- map["videos"]
    }
    
}

struct ChannelsDataVideos : Mappable {
    
    var id: Int = 0
    var title: String = ""
    var channel_id: Int = 0
    var topic_id: Int = 0
    var duration: Int = 0
    var front_cover: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    
    init() {}
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
    }
    
}