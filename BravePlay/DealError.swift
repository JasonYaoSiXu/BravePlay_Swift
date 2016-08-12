//
//  DealError.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/3.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation


enum MyErrorType : ErrorType {
    case NetWorkError
    case NoWayToParse
}

extension MyErrorType : CustomStringConvertible {
    
    var description : String {
        switch self {
        case .NetWorkError:
            return "网络错误"
        default:
            return "未知错误"
        }
    }
    
}