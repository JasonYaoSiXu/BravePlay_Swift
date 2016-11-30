//
//  Cache.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation


// get cache dir Path
func getCachesPath() -> String {
    
    let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) as [NSString]
    let cacheDir = path[0] as String
    
    return cacheDir
}

// 计算单个缓存文件的大小
func caculate(filePath: String) -> Float {
    let manager = NSFileManager.defaultManager()
    if manager.fileExistsAtPath(filePath) {
        do {
            let size = try manager.attributesOfItemAtPath(filePath)
            guard let fileSize = size[NSFileSize] as? Float else {
                return 0
            }
            return fileSize
        } catch {
            return 0.0
        }
    }
    return 0.0
}

//遍历每个文件，计算总共的缓存大小
func getCacheSizeAtPath(folderPath: String) -> String {
    
    let manager = NSFileManager.defaultManager()
    if !manager.fileExistsAtPath(folderPath) {
        return "0.0"
    }
    
    var size: Float = 0.0
    
    let childFilesEnumerator = manager.subpathsAtPath(folderPath)
    let filePath = folderPath as NSString

    guard let childePaths = childFilesEnumerator else {
        return "0.0"
    }

    for filePaths in childePaths {
        let fileAbsolutePath = filePath.stringByAppendingPathComponent(filePaths)
        size += caculate(fileAbsolutePath)
    }
    
    size = size / ( 1024.0 * 1024.0)
    if size < 0.1 {
        return "0.0"
    }
    
    return String(format: "%.1f", size)
}

// 清除缓存
func clearCache(path: String)  -> Bool {
    let manager = NSFileManager.defaultManager()
    var result: Bool = false
    
    if manager.fileExistsAtPath(path) {
        let childePath = manager.subpathsAtPath(path)
        let filePath = path as NSString
        
        guard let childePaths = childePath else {
            return false
        }
        
        for paths in childePaths {
            let subFilePath = filePath.stringByAppendingPathComponent(paths)
            do {
                try manager.removeItemAtPath(subFilePath)
                result = true
            } catch {
                result = false
            }
        }
        
        return result
    }
    
    return result
}
