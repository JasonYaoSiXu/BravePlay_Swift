//
//  UserData.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation

enum UserInfo: String {
    case Nickname = "nickname"
    case Avatar = "avatar"
    case Telephone = "telephone"
    case Email = "email"
    case Sex = "sex"
    case Access_token = "access_token"
    case Binding_phone = "binding_phone"
    case Default_contact_id = "default_contact_id"
    case Subscribe_channel = "subscribe_channel"
    case Subscribe_topic = "subscribe_topic"
    case Favorite_video = "favorite_video"
    case Favorite_activity = "favorite_activity"
}

//struct UserDataStruct {
//    var nickname: String = "哇他那呗"
//    var avatar: String = ""
//    var telephone: String = ""
//    var email: String = ""
//    var sex: Int = 0
//    var access_token: String = ""
//    var binding_phone: Bool = false
//    var default_contact_id: Int = 0
//    var subscribe_channel: [Int] = []
//    var subscribe_topic: [Int] = []
//    var favorite_video: [Int] = []
//    var favorite_activity: [Int] = []
//}

class UserData: NSObject {
    
    class var UserDatas : UserData {
        struct Singleton {
            static let instance = UserData()
        }
        return Singleton.instance
    }

    let userDefault = NSUserDefaults.standardUserDefaults()
    var isLoged: Bool? {
        return userDefault.boolForKey("UserLoged")
    }
    
    var nickName: String? {
        return userDefault.stringForKey(UserInfo.Nickname.rawValue)
    }
    
    var avatar: String? {
        return userDefault.stringForKey(UserInfo.Avatar.rawValue)
    }
    
    var telephone: String? {
        return userDefault.stringForKey(UserInfo.Telephone.rawValue)
    }
    
    var email: String? {
        return userDefault.stringForKey(UserInfo.Email.rawValue)
    }
    
    var sex: Int? {
        return userDefault.integerForKey(UserInfo.Sex.rawValue)
    }
    
    var access_token: String? {
        return userDefault.stringForKey(UserInfo.Access_token.rawValue)
    }
    
    var binding_phone: Bool? {
        return userDefault.boolForKey(UserInfo.Binding_phone.rawValue)
    }
    
    var default_contact_id: Int? {
        return userDefault.integerForKey(UserInfo.Default_contact_id.rawValue)
    }
    
    var subscribe_channel: [Int]? {
        guard let array = userDefault.arrayForKey(UserInfo.Subscribe_channel.rawValue) else {
            return nil
        }
        return array as? [Int]
    }
    
    var subscribe_topic: [Int]? {
        guard let array = userDefault.arrayForKey(UserInfo.Subscribe_topic.rawValue) else {
            return nil
        }
        return array as? [Int]
    }

    var favorite_video: [Int]? {
        guard let array = userDefault.arrayForKey(UserInfo.Favorite_video.rawValue) else {
            return nil
        }
        return array as? [Int]
    }

    var favorite_activity: [Int]? {
        guard let array = userDefault.arrayForKey(UserInfo.Favorite_activity.rawValue) else {
            return nil
        }
        return array as? [Int]
    }

    func userLogOut() {
        //string
        userDefault.removeObjectForKey(UserInfo.Nickname.rawValue)
        userDefault.removeObjectForKey(UserInfo.Avatar.rawValue)
        userDefault.removeObjectForKey(UserInfo.Telephone.rawValue)
        userDefault.removeObjectForKey(UserInfo.Email.rawValue)
        // int
        userDefault.removeObjectForKey(UserInfo.Sex.rawValue)
        //string
        userDefault.removeObjectForKey(UserInfo.Access_token.rawValue)
        //bool
        userDefault.removeObjectForKey(UserInfo.Binding_phone.rawValue)
        //int
        userDefault.removeObjectForKey(UserInfo.Default_contact_id.rawValue)
        //array
        userDefault.removeObjectForKey(UserInfo.Subscribe_channel.rawValue)
        userDefault.removeObjectForKey(UserInfo.Subscribe_topic.rawValue)
        userDefault.removeObjectForKey(UserInfo.Favorite_video.rawValue)
        userDefault.removeObjectForKey(UserInfo.Favorite_activity.rawValue)
        userDefault.setBool(false, forKey: "UserLoged")
    }
    
    func userLogIn(userData: UserLogData) {
        //string
        userDefault.setObject(userData.nickname, forKey: UserInfo.Nickname.rawValue)
        userDefault.setObject(userData.avatar, forKey: UserInfo.Avatar.rawValue)
        userDefault.setObject(userData.telephone, forKey: UserInfo.Telephone.rawValue)
        userDefault.setObject(userData.email, forKey: UserInfo.Email.rawValue)
        //int
        userDefault.setInteger(userData.sex, forKey: UserInfo.Sex.rawValue)
        //string
        userDefault.setObject(userData.access_token, forKey: UserInfo.Access_token.rawValue)
        //bool
        userDefault.setBool(userData.binding_phone, forKey: UserInfo.Binding_phone.rawValue)
        //int
        userDefault.setInteger(userData.default_contact_id, forKey: UserInfo.Default_contact_id.rawValue)
        //array
        userDefault.setObject(userData.subscribe_channel, forKey: UserInfo.Subscribe_channel.rawValue)
        userDefault.setObject(userData.subscribe_topic, forKey: UserInfo.Subscribe_topic.rawValue)
        userDefault.setObject(userData.favorite_video, forKey: UserInfo.Favorite_video.rawValue)
        userDefault.setObject(userData.favorite_activity, forKey: UserInfo.Favorite_activity.rawValue)
        userDefault.setBool(true, forKey: "UserLoged")
    }
    
}