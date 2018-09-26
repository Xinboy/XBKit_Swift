//
//  NSStringRegex.swift
//  XBZRenting-Swift
//
//  Created by Xinbo Hong on 2018/2/7.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    /****************** 正则表达式 ******************/
    struct PatternType {
        ///正则：合法邮箱
        static let Mail: String = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        ///正则：字母加数字以及下划线(6,18)
        static let Password: String = "^[A-Za-z0-9_-]{6,18}$"
        ///正则：十六进制数
        static let HexValue: String = "^#?([a-f0-9]{6}|[a-f0-9]{3})$"
        ///正则：合法URL
        static let URL: String = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        ///正则：中文
        static let Chinese: String = "[\\u4e00-\\u9fa5]"
        ///正则：中国身份证号
        static let IDCard: String = "\\d{15}(\\d\\d[0-9xX])?"
    }
    
    static func xb_BoolWithStrRegex(matchesStr: String, pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: matchesStr, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, matchesStr.count))
        if res.count > 0 {
            return true
        }
        return false
    }
    
    func xb_ReplaceWithPattern(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    /****************** 加密解密 ******************/
    func xb_StringWithAESEncrypt(key: String) -> String? {
        /*
         * 采用AES-128-CBC加密
         * 偏移量为：5efd3f6060e20330
         */
        do {
            let iv = "5efd3f6060e20330"
            let aes = try AES.init(key: key.bytes, blockMode: .CBC(iv: iv.bytes))
            let encrypt = try aes.encrypt(self.bytes)
            return encrypt.toHexString()
        } catch {
            print(error)
        }
        return nil
    }
    
    func xb_StringWithAESDecrypt(key: String) -> String? {
        /*
         * 采用AES-128-CBC解密
         * 偏移量为：5efd3f6060e20330
         */
        do {
            let iv = "5efd3f6060e20330"
            let aes = try AES.init(key: key.bytes, blockMode: .CBC(iv: iv.bytes))
            let decrypt = try aes.decrypt(self.bytes)
            return decrypt.toHexString()
        } catch {
            print(error)
        }
        
        return nil
    }
    
    
    
    
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            
            return String(subString)
        } else {
            return self
        }
    }
    
    public func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
}







