//
//  NotificationCenter+Extention.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/6/11.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

extension NotificationCenter {
    enum LocalAuthNotification: String {
        case Success
        case Failed
        case Cancel
        case InputPwd
        case NotAvailable
        case NotEnrolled
        case PasscodeNotSet
        case Locked
        
        var stringValue: String {
            return "LocalAuth" + rawValue
        }
        
        var notificationName: Notification.Name {
            return Notification.Name(stringValue)
        }
    }
    
    static func post(LocalAuthNotification name: LocalAuthNotification, object: Any? = nil){
        NotificationCenter.default.post(name: name.notificationName, object: object)
    }

}

