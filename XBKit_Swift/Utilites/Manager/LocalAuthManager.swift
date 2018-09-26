//
//  AuthManager.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/6/10.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

/*
 *  管理内容:    面容、指纹解锁
 *  控件完成情况: 基本完成
 */

import UIKit
import LocalAuthentication
class LocalAuthManager: NSObject {
    
    func validateAuthSetting() {
        let version = Double(UIDevice.current.systemVersion)!
        if version < 8.0 {
            return
        }
        
        let context = LAContext()
        context.localizedFallbackTitle = ""
        
        
        let reason = "验证"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            //指纹可用，可以调起指纹登录弹窗
        } else {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (isSuccess, failed) in
                if isSuccess {
                    
                } else {
                    if let error = failed as NSError? {
                        self.errorMessageForLAErrorCode(errorCode: error.code)
                    }
                }
            }
        }
        
        
    }
    
    func errorMessageForLAErrorCode(errorCode: Int) {
        printf(errorCode)
        switch errorCode {
        case LAError.biometryNotEnrolled.rawValue:
            printf("生物识别码未设置密码:\(errorCode)")
            break
        case LAError.passcodeNotSet.rawValue:
            printf("系统未设置密码:\(errorCode)")
            break
        case LAError.authenticationFailed.rawValue:
            printf("授权失败，3次尝试验证后，授权失败调用:\(errorCode)")
            break
        case LAError.appCancel.rawValue:
            printf("2:\(errorCode)")
            break
            
        case LAError.biometryLockout.rawValue:
            printf("4:\(errorCode)")
            break
        case LAError.biometryNotAvailable.rawValue:
            printf("设备Touch ID不可用，例如未打开:\(errorCode)")
            break
        case LAError.systemCancel.rawValue:
            printf("系统取消授权:\(errorCode)")
            break
        case LAError.userCancel.rawValue:
            printf("用户取消验证:\(errorCode)")
            break
        case LAError.userFallback.rawValue:
            printf("用户选择手动输入密码:\(errorCode)")
            break
        case LAError.invalidContext.rawValue:
            printf("7:\(errorCode)")
            break
        case LAError.notInteractive.rawValue:
            printf("8:\(errorCode)")
            break
        default:
            break
        }
    }
    
}

