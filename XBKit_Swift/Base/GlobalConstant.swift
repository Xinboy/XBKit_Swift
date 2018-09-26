//
//  Constant.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit
import Foundation

/****************** App Frame / Bounds      屏幕相关  ******************/
let kScreenWidth: CGFloat         = UIScreen.main.bounds.size.width
let kScreenHeight: CGFloat        = UIScreen.main.bounds.size.height
/** 顶部参数*/
var kStatusBarHeight: CGFloat {
    return UIDevice.xb_PhoneTypeWithCurrentDevice() == UIDevice.PhoneTypeWithSize.X ? 44.0 : 20.0
}
let kNavigationBarHeight: CGFloat = 44.0
let kTopBarHeight: CGFloat        = kStatusBarHeight + kNavigationBarHeight
/** 底部参数*/
let kTabBarHeight:CGFloat         = 49.0;
var kBottomDangerHeight: CGFloat {
    return UIDevice.xb_PhoneTypeWithCurrentDevice() == UIDevice.PhoneTypeWithSize.X ? 44.0 : 20.0
}
let kBottomBarHeight: CGFloat     = kBottomDangerHeight + kTabBarHeight
/** 屏幕分辨率*/
let screenScale:CGFloat           = UIScreen.main.responds(to: #selector(getter: UIScreen.main.scale)) ? UIScreen.main.scale : 1.0

/****************** App Version / Info Plist  设备系统版本 ******************/
let kiOSVersion: String           = UIDevice.current.systemVersion
let kOsType: String               = UIDevice.current.systemName + UIDevice.current.systemVersion

/** AppID, 在App Store中查找*/
let kAppID                        = "1149168206"
let kInfoDictionary               = Bundle.main.infoDictionary
/** App名称*/
let kAppName: String?             = kInfoDictionary!["CFBundleDisplayName"] as? String
/** App版本号*/
let kAppVersion: String?          = kInfoDictionary!["CFBundleShortVersionString"] as? String
/** Appbuild版本号*/
let kAppBuildVersion: String?     = kInfoDictionary!["CFBundleVersion"] as? String
/** app bundleId*/
let kAppBundleId: String?         = kInfoDictionary!["CFBundleIdentifier"] as? String
/** 平台名称（iphonesimulator 、 iphone）*/
let platformName: String?         = kInfoDictionary!["DTPlatformName"] as? String


/****************** Catch / Documents           文件夹 ******************/
let kCacheDirectory               = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
let kDocumentDirectory            = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first

/****************** UserDefault's Key          文件夹 ******************/
let kUserDefault                  = UserDefaults.standard
let kTokenKey                     = "UserDefaultsTokenKey"
let kUIDKey                       = "UserDefaultsUIDKey"
let kExpireKey                    = "UserDefaultsExpireKey"

/****************** UnClassification ******************/
let kClearColor = UIColor.clear



