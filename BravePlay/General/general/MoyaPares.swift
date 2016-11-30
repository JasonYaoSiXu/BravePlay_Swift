//
//  MoyaPares.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/3.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation
import ObjectMapper
import Result
import Moya

protocol MoyaPares {
    func paresObject<T:Mappable>(resultResponse: Result<Moya.Response, Error>) -> Result<T, MyErrorType>
    func paresObjectArray<T:Mappable>(resultResponse: Result<Moya.Response, Error>) -> Result<[T], MyErrorType>
}

extension MoyaPares {
    
    func paresObject<T:Mappable>(resultResponse: Result<Moya.Response, Error>) -> Result<T, MyErrorType> {
        return resultResponse.flatMapError(dealError).flatMap(checkStatusCode).flatMap(toJson).flatMap(toObjectModel)
    }
    
    func paresObjectArray<T:Mappable>(resultResponse: Result<Moya.Response, Error>) -> Result<[T], MyErrorType> {
        return resultResponse.flatMapError(dealError).flatMap(checkStatusCode).flatMap(toJson).flatMap(toObjectModelArray)
    }
    
    private func dealError(error: Error) -> Result<Moya.Response, MyErrorType> {
        return .Failure(MyErrorType.NetWorkError)
    }
    
    private  func checkStatusCode(response: Moya.Response) -> Result<Moya.Response, MyErrorType> {
        if response.statusCode == 200 {
            return .Success(response)
        }
        return .Failure(MyErrorType.HttpErrorCode(code: response.statusCode))
    }
    
    private func toJson(response: Moya.Response) -> Result<AnyObject, MyErrorType> {
        do {
            return .Success(try response.mapJSON())
        } catch {
            return .Failure(MyErrorType.NoWayToParse)
        }
    }
    
    private func toObjectModel<T:Mappable>(json: AnyObject) -> Result<T, MyErrorType> {
        
        guard let resultJson = Mapper<T>().map(json) else{
            return .Failure(.NetWorkError)
        }
        
        return .Success(resultJson)
    }
    
    private func toObjectModelArray<T:Mappable>(json: AnyObject) -> Result<[T], MyErrorType> {
        
        guard let resultJson = Mapper<T>().mapArray(json) else{
            return .Failure(.NetWorkError)
        }
        
        return .Success(resultJson)
    }
    
}