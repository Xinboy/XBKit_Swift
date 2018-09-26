//
//  ClearCatch.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/6/7.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class ClearCatch: NSObject {
    class func fileSize(path: String) -> UInt64{
        let manager = FileManager.default
        if manager.fileExists(atPath: path) {
            do {
                let size = try manager.attributesOfItem(atPath: path)[FileAttributeKey.size] as! UInt64
                return size
            } catch {
                printf(error)
            }
        }
        return 0
    }
    
    class func folderSizeInCachesPath() -> Double{
        let path = kCacheDirectory
        let manager = FileManager.default
        
        if !manager.fileExists(atPath: path!) {
            return 0
        }
        
        var folderSize: UInt64 = 0
        do {
            let files = try manager.contentsOfDirectory(atPath: path!)
            for file in files {
                let path = kCacheDirectory! + "/\(file)"
                folderSize = folderSize + ClearCatch.fileSize(path: path)
            }
        } catch {
            printf(error)
        }
        return Double(folderSize) / (1024.0*1024.0)
    }
}
