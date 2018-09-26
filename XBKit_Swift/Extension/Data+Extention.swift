//
//  Data+Extention.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/6/5.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation
import CryptoSwift
extension Data {
    func aes256_encrypt(key: String) -> Data{
        
        var encrypted: [UInt8] = []
        let key: [UInt8] = (key.data(using: .utf8)?.bytes)!
        let iv: [UInt8] = ("5efd3f6060e20330".data(using: .utf8)?.bytes)!
        
        do {
            encrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).encrypt(self.bytes)
        } catch  {
            
        }
        let encode = Data.init(bytes: encrypted)
        return encode.base64EncodedData(options: Base64EncodingOptions.lineLength64Characters)
    }
    
    func aes256_decrypt(key: String) -> Data {
        var decrypted: [UInt8] = []
        
        let key: [UInt8] = (key.data(using: .utf8)?.bytes)!
        let iv: [UInt8] = ("5efd3f6060e20330".data(using: .utf8)?.bytes)!
        do {
            decrypted = try AES(key: key, blockMode: .CBC(iv: iv), padding: .pkcs7).decrypt(self.bytes)
        } catch {
            
        }
        let decode = Data.init(bytes: decrypted)
        return decode.base64EncodedData(options: Base64EncodingOptions.lineLength64Characters)
    }
}
