//
//  ActivitySectionModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

// 全部 filter = 0 热门 filter = 12 免费 filter = 14 室内 filter = 5 课程 filter = 13

//城市列表
struct Location: Mappable {
    
    var id: String = ""
    var title: String = ""
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
    
}

// 全部活动
struct AllActivity : Mappable {
    
    var currentPage: Int = 0
    var pageCount: Int = 0
    var list: [RankList] = []
    init() {}
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        currentPage <- map["currentPage"]
        pageCount <- map["pageCount"]
        list <- map["list"]
    }
}

// 热门活动
struct HotActivity : Mappable {
    var currentPage: Int = 0
    var pageCount: Int = 0
    var list: [RankList] = []
    
    init() {}
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        currentPage <- map["currentPage"]
        pageCount <- map["pageCount"]
        list <- map["list"]
    }
}

// 免费活动
struct FreeActivity :  Mappable {
    var currentPage: Int = 0
    var pageCount: Int = 0
    var list: [RankList] = []
    
    init() {}
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        currentPage <- map["currentPage"]
        pageCount <- map["pageCount"]
        list <- map["list"]
    }
}

// 室内活动
struct RoomActivity : Mappable {
    var currentPage: Int = 0
    var pageCount: Int = 0
    var list: [RankList] = []
    
    init() {}
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        currentPage <- map["currentPage"]
        pageCount <- map["pageCount"]
        list <- map["list"]
    }
}

//课程活动
struct CourseActivity :  Mappable {
    var currentPage: Int = 0
    var pageCount: Int = 0
    var list: [RankList] = []
    
    init() {}
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        currentPage <- map["currentPage"]
        pageCount <- map["pageCount"]
        list <- map["list"]
    }
}

//List
struct List : Mappable {
    
    var id: String = ""
    var channel_id: String = ""
    var title: String = ""
    var p_num_limit: String = ""
    var p_num: String = ""
    var expense: String = ""
    var avatar: String = ""
    var description: String = ""
    var location: String = ""
    var s_location: String = ""
    var network_video_source_id: String = ""
    var status: String = ""
    var activity_content_sort: String = ""
    var score: String = ""
    var sort: String = ""
    var is_apply: String = ""
    var view_count: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var qrcode: String = ""
    var h5_link: String = ""
    var review_img: String = ""
    var scan_reply: String = ""
    var contact: String = ""
    var type: String = ""
    var date_limited_for_longtime: String = ""
    var platform_visible: String = ""
    var ticketTimes : [TicketTimes] = []
    var rank: String = ""
    var time: String = ""
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        channel_id <- map["channel_id"]
        title <- map["title"]
        p_num_limit <- map["p_num_limit"]
        p_num <- map["p_num"]
        expense <- map["expense"]
        avatar <- map["avatar"]
        description <- map["description"]
        location <- map["location"]
        s_location <- map["s_location"]
        network_video_source_id <- map["network_video_source_id"]
        status <- map["status"]
        activity_content_sort <- map["activity_content_sort"]
        score <- map["score"]
        sort <- map["sort"]
        is_apply <- map["is_apply"]
        view_count <- map["view_count"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        qrcode <- map["qrcode"]
        h5_link <- map["h5_link"]
        review_img <- map["review_img"]
        scan_reply <- map["scan_reply"]
        contact <- map["contact"]
        type <- map["type"]
        date_limited_for_longtime <- map["date_limited_for_longtime"]
        platform_visible <- map["platform_visible"]
        time <- map["time"]
    }
    
}

//RankList
struct RankList : Mappable {
    var id: String = ""
    var channel_id: String = ""
    var title: String = ""
    var p_num_limit: String = ""
    var p_num: String = ""
    var expense: String = ""
    var avatar: String = ""
    var description: String = ""
    var location: String = ""
    var s_location: String = ""
    var network_video_source_id: String = ""
    var status: String = ""
    var activity_content_sort: String = ""
    var score: String = ""
    var sort: String = ""
    var is_apply: String = ""
    var view_count: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var qrcode: String = ""
    var h5_link: String = ""
    var review_img: String = ""
    var scan_reply: String = ""
    var contact: String = ""
    var type: String = ""
    var date_limited_for_longtime: String = ""
    var platform_visible: String = ""
    var ticketTimes : [TicketTimes] = []
    var rank: String = ""
    var time: String = ""
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        channel_id <- map["channel_id"]
        title <- map["title"]
        p_num_limit <- map["p_num_limit"]
        p_num <- map["p_num"]
        expense <- map["expense"]
        avatar <- map["avatar"]
        description <- map["description"]
        location <- map["location"]
        s_location <- map["s_location"]
        network_video_source_id <- map["network_video_source_id"]
        status <- map["status"]
        activity_content_sort <- map["activity_content_sort"]
        score <- map["score"]
        sort <- map["sort"]
        is_apply <- map["is_apply"]
        view_count <- map["view_count"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        qrcode <- map["qrcode"]
        h5_link <- map["h5_link"]
        review_img <- map["review_img"]
        scan_reply <- map["scan_reply"]
        contact <- map["contact"]
        type <- map["type"]
        date_limited_for_longtime <- map["date_limited_for_longtime"]
        platform_visible <- map["platform_visible"]
        ticketTimes <- map["ticketTimes"]
        rank <- map["rank"]
        time <- map["time"]
    }

}

//TicketTimes
struct TicketTimes : Mappable {
    
    var id : String = ""
    var activity_id: String = ""
    var time: String = ""
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        activity_id <- map["activity_id"]
        time <- map["time"]
    }
    
}


//result Data
struct ResultData {
    var currentPage: Int = 0
    var pageCount: Int = 0
    var rankList: [RankList] = []
}

