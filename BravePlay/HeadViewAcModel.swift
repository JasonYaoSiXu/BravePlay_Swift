//
//  HeadViewAcModel.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/4.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper

//活动咨询
struct ConsultDetail: Mappable {
    var id: Int = 0
    var body: String = ""
    var answer_counts: Int = 0
    var sort: Int = 0
    var status: Int = 0
    var created_at: Int = 0
    var updated_at: Int = 0
    var answers: [ConsultAnswers] = []
    var userDetail: ConsultUserDetail = ConsultUserDetail()
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        body <- map["body"]
        answer_counts <- map["answer_counts"]
        sort <- map["sort"]
        status <- map["status"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        answers <- map["answers"]
        userDetail <- map["userDetail"]
    }
    
}

struct ConsultAnswers: Mappable {
    var id: Int = 0
    var question_id: Int = 0
    var body: String = ""
    var created_at: Int = 0
    var updated_at: Int = 0
    var userDetail: ConsultUserDetail = ConsultUserDetail()
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        question_id <- map["question_id"]
        body <- map["body"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        userDetail <- map["userDetail"]
    }
}

struct ConsultUserDetail: Mappable {
    var nickname: String = ""
    var avatar: String = ""
    
    init() {}
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        nickname <- map["nickname"]
        avatar <- map["avatar"]
    }
}

//活动详情
struct ActivitysReponse : Mappable {
    var id: Int = 0
    var headimg: String = ""
    var qrcode: String = ""
    var title: String = ""
    var name: String = ""
    var avatar: String = ""
    var shareLink: String = ""
    var enrollNumber: String = ""
    var p_num_limit: Int = 0
    var location: String = ""
    var s_location: String = ""
    var contact: String = ""
    var ticketList: [ActivitysTicketList] = []
//    var contentList : [String] = []
    var share_content: String = ""
    var enrollList: [ActivitysEnrollList] = []
    var paymentType: [ActivitysPayWays] = []
    var type: Int = 0
    var isEnrolled: Bool = false
    var h5: String = ""
    var date_limited_for_longtime: String = ""
    var tipContents: [ActivityTipContents] = []
    var scheduleContents: [ActivitysScheduleContents] = []
    var singleContents: [ActivitysSingleContents] = []
    var hasSchedule: Bool = false
    var avatarGallery: [ActivitysAvatarGallery] = []
    var detail_page_url: String = ""
    var is_apply: Int = 0
    
    init() {}
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        headimg <- map["headimg"]
        qrcode <- map["qrcode"]
        title <- map["title"]
        name <- map["name"]
        avatar <- map["avatar"]
        shareLink <- map["shareLink"]
        enrollNumber <- map["enrollNumber"]
        p_num_limit <- map["p_num_limit"]
        location <- map["location"]
        s_location <- map["s_location"]
        contact <- map["contact"]
        ticketList <- map["ticketList"]
        share_content <- map["share_content"]
        enrollList <- map["enrollList"]
        paymentType <- map["paymentType"]
        type <- map["type"]
        isEnrolled <- map["isEnrolled"]
        h5 <- map["h5"]
        date_limited_for_longtime <- map["date_limited_for_longtime"]
        tipContents <- map["tipContents"]
        scheduleContents <- map["scheduleContents"]
        singleContents <- map["singleContents"]
        hasSchedule <- map["hasSchedule"]
        avatarGallery <- map["avatarGallery"]
        detail_page_url <- map["detail_page_url"]
        is_apply <- map["is_apply"]
    }
}

///票务类型
struct ActivitysTicketList: Mappable {
    var id: String = ""
    var activity_id: String = ""
    var time: String = ""
    var tickets: [ActivitysTickets] = []
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        activity_id <- map["activity_id"]
        time <- map["time"]
        tickets <- map["tickets"]
    }
    
}

///票务详情
struct ActivitysTickets: Mappable {
    var id: String = ""
    var activity_id: String = ""
    var title: String = ""
    var price: String = ""
    var ticket_sum: String = ""
    var ticket_balance: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    var status: String = ""
    var single_limit: String = ""
    var ticket_time_id: String = ""
    var notice: String = ""
    var description: String = ""
    var original_price: String = ""
    var isSoldOut: Bool = false
    var isActive: Bool = false
    var singleLimited: Bool = false
    var ticketFormItems: [ActivitysTicketFroms] = []
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        activity_id <- map["activity_id"]
        title <- map["title"]
        price <- map["price"]
        ticket_sum <- map["ticket_sum"]
        ticket_balance <- map["ticket_balance"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        status <- map["status"]
        single_limit <- map["single_limit"]
        ticket_time_id <- map["ticket_time_id"]
        notice <- map["notice"]
        description <- map["description"]
        original_price <- map["original_price"]
        isSoldOut <- map["isSoldOut"]
        isActive <- map["isActive"]
        singleLimited <- map["singleLimited"]
        ticketFormItems <- map["ticketFormItems"]
    }
}

///购票需要填写的信息
struct ActivitysTicketFroms: Mappable {
    
    var id: Int = 0
    var type_id: Int = 0
    var label: String = ""
    var required: Int = 0
    var position: Int = 0
    var preg: String = ""
    var placeholder: String = ""
    var error_message: String = ""
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        type_id <- map["type_id"]
        label <- map["label"]
        required <- map["required"]
        position <- map["position"]
        preg <- map["preg"]
        placeholder <- map["placeholder"]
        error_message <- map["error_message"]
    }
}

///
struct ActivitysEnrollList: Mappable {
    var id: Int = 0
    var user_id: Int = 0
    var avatar: String = ""
    var nickname: String = ""
    var num: Int = 0
    var status: Int = 0
    var created_at: Int = 0
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        avatar <- map["avatar"]
        nickname <- map["nickname"]
        num <- map["num"]
        status <- map["status"]
        created_at <- map["created_at"]
    }
}

///支付方式
struct ActivitysPayWays: Mappable {
    
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
    }
}

///敢玩tips
struct ActivityTipContents: Mappable {
    
    var title: String  = ""
    var content: String = ""
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
    }
    
}

struct ActivitysScheduleContents : Mappable {
    
    var id: Int = 0
    var title: String = ""
    var content: String = ""
    var label: String = ""
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        content <- map["content"]
        label <- map["label"]
    }
    
}

struct ActivitysSingleContents : Mappable {
    var title: String = ""
    var content: String = ""
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
    }
}

///轮播图
struct ActivitysAvatarGallery : Mappable {
    var url: String = ""
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        url <- map["url"]
    }
}


