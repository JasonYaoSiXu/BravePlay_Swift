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
    case ParseError
    case HttpErrorCode(code: Int)
}

extension MyErrorType : CustomStringConvertible {
    
    var description : String {
        switch self {
        case .NetWorkError:
            return "网络错误"
        case .ParseError:
            return "解析错误"
        case .HttpErrorCode(let code):
            switch  code {
            case 500 :
                return "500 错误"
            case 401:
                return "401 错误"
            default:
                return "其它错误"
            }
        default:
            return "未知错误"
        }
    }
    
}