//
//  general.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/26.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation

enum Regular : String {
    case PhoneNumber = "^1\\d{10}$"
}

//正则表达式
func regularExpression(phoneNumber: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", "^1\\d{10}$")
    return predicate.evaluateWithObject(phoneNumber)
}