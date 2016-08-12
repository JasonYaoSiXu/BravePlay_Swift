//
//  MainSectionModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

//顶部轮播图
struct BannerItem: Mappable {
    var dist_id: String = ""
    var description: String = ""
    var created_at: String = ""
    var img_url: String = ""
    var img_mobile_url: String = ""
    var type: String = ""
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        dist_id <- map["dist_id"]
        description <- map["description"]
        created_at <- map["created_at"]
        img_url <- map["img_url"]
        img_mobile_url <- map["img_mobile_url"]
        type <- map["type"]
    }
}

//敢玩趣闻
struct ArticleItem: Mappable {
    
    var id: String = ""
    var date_time: Int = 0
    var cover: String = ""
    var title: String = ""
    var digest: String = ""
    var author: String = ""
    var read_num: Int = 0
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        date_time <- map["date_time"]
        cover <- map["cover"]
        title <- map["title"]
        digest <- map["digest"]
        author <- map["author"]
        read_num <- map["read_num"]
    }
    
}

//敢玩活动
struct ActivityResponse: Mappable {
    var count: String = ""
    var activityItem: [ActivityItem] = []
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        activityItem <- map["models"]
        count <- map["count"]
    }
    
}

struct ActivityItem: Mappable {
    
    var id: String = ""
    var avatar: String = ""
    var title: String = ""
    var s_location: String = ""
    var expense: String = ""
    var view_count: String = ""
    var time: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        avatar <- map["avatar"]
        title <- map["title"]
        s_location <- map["s_location"]
        expense <- map["expense"]
        view_count <- map["view_count"]
        time <- map["time"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}

//敢玩TV
struct TvResponse: Mappable {
    
    var count: String = ""
    var tvItem: [TvItem] = []
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        count <- map["count"]
        tvItem <- map["models"]
    }
}

struct TvItem: Mappable {
    
    var id: String = ""
    var front_cover: String = ""
    var title: String = ""
    var name: String = ""
    var duration: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        front_cover <- map["front_cover"]
        title <- map["title"]
        name <- map["name"]
        duration <- map["duration"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
}

//自频道精选
struct ChannelResponse: Mappable {
    
    var dataList: [ChnnelItem] = []
    var count: String = ""
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        count <- map["count"]
        dataList <- map["models"]
    }
}

struct ChnnelItem: Mappable {
    var id: Int = 0
    var avatar: String = ""
    var headimg: String = ""
    var name: String = ""
    var hasSub: Bool = false
    var created_at: Int = 0
    var updated_at: Int = 0
    
    init() {
        
    }
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        avatar <- map["avatar"]
        headimg <- map["headimg"]
        name <- map["name"]
        hasSub <- map["hasSub"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
}

//Topic 推荐
struct TopicResponse: Mappable {
    
    var count: String = ""
    var dataList: [TopicItem] = []
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        count <- map["count"]
        dataList <- map["models"]
    }
    
}

struct TopicItem: Mappable {
    
    var id: String = ""
    var avatar: String = ""
    var headimg: String = ""
    var name: String = ""
    var hasSub: Bool = false
    var created_at: Int = 0
    var updated_at: Int = 0
    
    init() {
        
    }
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        avatar <- map["avatar"]
        headimg <- map["headimg"]
        name <- map["name"]
        hasSub <- map["hasSub"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
}




