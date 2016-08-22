//
//  MineModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/22.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

//登录信息 token
struct UserLogIn: Mappable {
    var access_token: String = ""
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        access_token <- map["access_token"]
    }
    
}

//用户信息
struct UserLogData: Mappable {
    var nickname: String = "哇嗒"
    var avatar: String = ""
    var telephone: String = ""
    var email: String = ""
    var sex: Int = 0
    var access_token: String = ""
    var binding_phone: Bool = false
    var default_contact_id: Int = 0
    var subscribe_channel: [Int] = []
    var subscribe_topic: [Int] = []
    var favorite_video: [Int] = []
    var favorite_activity: [Int] = []
    
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
        default_contact_id <- map["default_contact_id"]
        subscribe_channel <- map["subscribe_channel"]
        subscribe_topic <- map["subscribe_topic"]
        favorite_video <- map["favorite_video"]
        favorite_activity <- map["favorite_activity"]
    }
}


//未读消息
struct UnReadCount : Mappable {
    
    var unread_notification_count: Int = 0
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        unread_notification_count <- map["unread_notification_count"]
    }
    
}

//消息列表
struct UserMessage : Mappable {
    
    var id: Int = 0
    var is_read: Bool = false
    var created_at: String = ""
    var notification : UserMessageNotification = UserMessageNotification()
    var sender : UserMessageSender = UserMessageSender()
    var question : UserMessageQuestion = UserMessageQuestion()
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        is_read <- map["is_read"]
        created_at <- map["created_at"]
        notification <- map["notification"]
        sender <- map["sender"]
        question <- map["question"]
    }
}

struct UserMessageNotification : Mappable {
    
    var action: Int = 0
    var target: Int = 0
    var target_type: Int = 0
    var type: Int = 0
    var content: String = ""
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        action <- map["action"]
        target <- map["target"]
        target_type <- map["target_type"]
        type <- map["type"]
        content <- map["content"]
    }
    
}

struct UserMessageSender : Mappable {
    
    var avatar: String = ""
    var nickname: String = ""
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        avatar <- map["avatar"]
        nickname <- map["nickname"]
    }
    
}

struct UserMessageQuestion : Mappable {
    
    var id: Int = 0
    var activity_id: Int = 0
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        activity_id <- map["activity_id"]
    }
    
}

// 关注列表

struct UserCareList : Mappable {
    
    var models: [UserCare] = []
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        models <- map["models"]
    }
    
}

struct UserCare : Mappable {
    
    var id : Int = 0
    var type: String = ""
    var avatar: String = ""
    var headimg: String = ""
    var name: String = ""
    var hasSub: Bool = false
    var videos: [UserCareVideos] = []
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        avatar <- map["avatar"]
        headimg <- map["headimg"]
        name <- map["name"]
        hasSub <- map["hasSub"]
        videos <- map["videos"]
    }
    
}

struct UserCareVideos :  Mappable {
    
    var id : String = ""
    var front_cover: String = ""
    var title: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var isNew: Bool = false
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        front_cover <- map["front_cover"]
        title <- map["title"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        isNew <- map["isNew"]
    }
    
}

// 用户喜欢
struct UserLike : Mappable {
    
    var video_id: Int = 0
    var topic_id: Int = 0
    var updated_at: Int = 0
    var video : UserLikeVideo = UserLikeVideo()
    var topic : UserLikeTopic = UserLikeTopic()
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        video_id <- map["video_id"]
        topic_id <- map["topic_id"]
        updated_at <- map["updated_at"]
        video <- map["video"]
        topic <- map["topic"]
    }
    
}

struct UserLikeVideo : Mappable {
    
    var description: String = ""
    var id: Int = 0
    var title: String = ""
    var video_source_id: Int = 0
    var channel_id: Int = 0
    var topic_id: Int = 0
    var url: String = ""
    var vid: String = ""
    var duration: Int = 0
    var type: String = ""
    var front_cover: String = ""
    var url_type: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var status: Int = 0
    var video_intro_sort: String = ""
    var platform_visible: Int = 0
    var index_display: Int = 0
    var everyday_display: Int = 0
    var list_img: String = ""
    var list_style: Int = 0
    var publish_at: Int = 0
    
    init() {}
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        description <- map["description"]
        id <- map["id"]
        title <- map["title"]
        video_source_id <- map["video_source_id"]
        channel_id <- map["channel_id"]
        topic_id <- map["topic_id"]
        url <- map["url"]
        vid <- map["vid"]
        duration <- map["duration"]
        type <- map["type"]
        front_cover <- map["front_cover"]
        url_type <- map["url_type"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        status <- map["status"]
        video_intro_sort <- map["video_intro_sort"]
        platform_visible <- map["platform_visible"]
        index_display <- map["index_display"]
        everyday_display <- map["everyday_display"]
        list_img <- map["list_img"]
        list_style <- map["list_style"]
        publish_at <- map["publish_at"]
    }
}

struct UserLikeTopic : Mappable {
    
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


