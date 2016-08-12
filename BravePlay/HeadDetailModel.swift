//
//  HeadDetailModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/10.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

//视频
struct VideosResponse : Mappable {
    
    var id: Int = 0
    var title: String = ""
    var channel_id: Int = 0
    var topic_id: Int = 0
    var duration: Int = 0
    var front_cover: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var detail: VideosDetail = VideosDetail()
    var topic: VideosTopic = VideosTopic()
    var channel: VideosChannel = VideosChannel()
    
    init() {}
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        channel_id <- map["channel_id"]
        topic_id <- map["topic_id"]
        duration <- map["duration"]
        front_cover <- map["front_cover"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        detail <- map["detail"]
        topic <- map["topic"]
        channel <- map["channel"]
    }
    
}

struct VideosDetail: Mappable {
    
    var play_url: String = ""
    var share_link: String = ""
    var share_content: String = ""
    var content: String = ""
    
    init() {}
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        play_url <- map["play_url"]
        share_link <- map["share_link"]
        share_content <- map["share_content"]
        content <- map["content"]
    }
}

struct VideosTopic: Mappable {
    
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
    
    init?(_ map: Map) {
    }
    
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

struct VideosChannel: Mappable {
    
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
    
    init?(_ map: Map) {
    }
    
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

//评论
struct VideosBarrages : Mappable {
    
    var id: Int = 0
    var content: String = ""
    var created_at: Int = 0
    var userDetail: VideosUserDetail = VideosUserDetail()
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        created_at <- map["created_at"]
        userDetail <- map["userDetail"]
    }
    
}

struct VideosUserDetail: Mappable {
    
    var birthday: String = ""
    var avatar: String = ""
    var nickname: String = ""
    var telephone: String = ""
    var sex: Int = 0
    var default_contact_id: Int = 0
    
    init() {}
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        birthday <- map["birthday"]
        avatar <- map["avatar"]
        nickname <- map["nickname"]
        telephone <- map["telephone"]
        sex <- map["sex"]
        default_contact_id <- map["default_contact_id"]
    }
}

//视频推荐
struct VideosRecommends: Mappable {
    
    var id: Int = 0
    var title: String = ""
    var channel_id: Int = 0
    var topic_id: Int = 0
    var duration: Int = 0
    var front_cover: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var topic: VideosTopic = VideosTopic()
    
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
    }
}

