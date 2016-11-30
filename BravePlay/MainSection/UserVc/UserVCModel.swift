//
//  UserVCModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

//当前用户数据
struct UserResponse : Mappable {
    
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
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        avatar <- map["avatar"]
        url <- map["url"]
        description <- map["description"]
        headimg <- map["headimg"]
        pc_headimg <- map["pc_headimg"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}

//推荐关注
struct UserRecommendResponse: Mappable {
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
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        avatar <- map["avatar"]
        url <- map["url"]
        description <- map["description"]
        headimg <- map["headimg"]
        pc_headimg <- map["pc_headimg"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
}

//该用户发布的视频
struct UserIssueVideosResponse: Mappable {
    
    var id: Int = 0
    var title: String = ""
    var channel_id: Int = 0
    var topic_id: Int = 0
    var duration: Int = 0
    var front_cover: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var topic: UserIssueTopicResponse = UserIssueTopicResponse()
    var channel: UserIssueChannelResponse = UserIssueChannelResponse()
    
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
        topic <- map["topic"]
        channel <- map["channel"]
    }
}

struct UserIssueTopicResponse: Mappable {
    
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

struct UserIssueChannelResponse: Mappable {
    
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


//topic
struct TopicUserResponse: Mappable {
    var id: Int = 0
    var name: String = ""
    var avatar: String = ""
    var headimg: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var recommend_normal_image: String = ""
    var recommend_hover_image: String = ""
    var recommend_background_image: String = ""
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        recommend_normal_image <- map["recommend_normal_image"]
        avatar <- map["avatar"]
        recommend_hover_image <- map["recommend_hover_image"]
        recommend_background_image <- map["recommend_background_image"]
        headimg <- map["headimg"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
}

struct TopicRecommand: Mappable {
    
    var id: Int = 0
    var name: String = ""
    var avatar: String = ""
    var headimg: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var recommend_normal_image: String = ""
    var recommend_hover_image: String = ""
    var recommend_background_image: String = ""
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        recommend_normal_image <- map["recommend_normal_image"]
        avatar <- map["avatar"]
        recommend_hover_image <- map["recommend_hover_image"]
        recommend_background_image <- map["recommend_background_image"]
        headimg <- map["headimg"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
}

struct TopicIssueVideosResponse: Mappable {
    
    var id: Int = 0
    var title: String = ""
    var channel_id: Int = 0
    var topic_id: Int = 0
    var duration: Int = 0
    var front_cover: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var topic: TopicIssueTopicResponse = TopicIssueTopicResponse()
    var channel: TopicIssueChannelResponse = TopicIssueChannelResponse()
    
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
        topic <- map["topic"]
        channel <- map["channel"]
    }
}

struct TopicIssueTopicResponse: Mappable {
    
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

struct TopicIssueChannelResponse: Mappable {
    
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
