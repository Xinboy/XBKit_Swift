//
//  NetworkEngine.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/6/5.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import AdSupport
import Alamofire
import SwiftyJSON

#if DEBUG
let kBaseURL: String = "http://testapi.xiaobaizu.com/Api/"
#else
let kBaseURL: String = "https://api.xiaobaizu.com/Api/"
#endif

class NetworkEngine: NSObject {
    
    // MARK: -  /**************** 属性设置 **************************/
    private let manager: SessionManager = {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        
        return SessionManager(configuration: config)
    }()
    
    //单例
    static let _sharedInstance = NetworkEngine()
    class func shareInstance() -> NetworkEngine {
        return _sharedInstance
    }
    
    //保证Token请求当且只有一个任务
    private var isGettingToken: Bool = false
    //所有请求加入该队列，方便失败后
    private var netQueue: OperationQueue = OperationQueue()
    // MARK: -  /**************** 网络请求 **************************/
    /// 获取当前WiFi的SSID
    ///
    /// - Returns: SSID
    class func fetchSSIDInfo() -> String {
        let interfaces = CNCopySupportedInterfaces()
        var ssid: String = ""
        if interfaces != nil {
            let interfacesArray = CFBridgingRetain(interfaces) as! Array<Any>
            if interfacesArray.count > 0 {
                let interfaceName = interfacesArray[0] as! CFString
                let ussafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName)
                if ussafeInterfaceData != nil {
                    let interfaceData = ussafeInterfaceData as! Dictionary<String, Any>
                    ssid = interfaceData["SSID"]! as! String
                }
            }
        }
        return ssid
    }
    
    
    
    /// 获取Token
    /// 2. Token请求失败多次，取消任务队列的所有任务
    /// 3. 请求返回错误多次，取消任务队列的所有任务
    ///
    /// - Parameter requestCount: 请求次数，默认为0（请求次数大于1取消所有任务）
    class func getToken(requestCount: NSInteger) {
        NetworkEngine.shareInstance().isGettingToken = true
        let urlStr = kBaseURL + "/Oauth/get_token.html"
        let tokenKey = "xbz_20170824#u8p"
        let adID = ASIdentifierManager.shared().advertisingIdentifier.uuidString.replacingOccurrences(of: "-", with: "")
        let adIDEn: String = adID.xb_StringWithAESEncrypt(key: tokenKey)!
        
        let params = ["appid": adIDEn]
        
        NetworkEngine.shareInstance().manager.request(urlStr, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let dict = json as! Dictionary<String, Any>
                let code = dict["code"] as! String
                if code == "0000" {
                    let data = dict["data"] as! Dictionary<String, String>
                    kUserDefault.set(data["expire"], forKey: kExpireKey)
                    kUserDefault.set(data["token"], forKey: kTokenKey)
                } else {
                    if requestCount > 2 {
                        NetworkEngine.shareInstance().netQueue.cancelAllOperations()
                        return
                    } else {
                        getToken(requestCount: requestCount + 1)
                    }
                }
                break
            case .failure(let error):
                if requestCount > 2 {
                    NetworkEngine.shareInstance().netQueue.cancelAllOperations()
                    return
                } else {
                    getToken(requestCount: requestCount + 1)
                }
                printf(error)
                break
            }
        }

    }

    ///!!! 当Token有效，但是请求直接走failure，无法处理好异步任务的取消
    /// 网络请求
    /// 1. Token过期，暂停任务队列，优先获取Token
    /// 2. Token请求失败，取消任务队列的所有任务
    /// 3. 返回错误多次，取消任务队列的所有任务
    ///
    /// - Parameters:
    ///   - urlString: URL字符串
    ///   - method: 请求方法
    ///   - parameters: 参数列表
    ///   - requestCount: 请求次数，默认为0（请求次数大于1取消所有任务）
    ///   - finished: 外部闭包，通常只需处理成功即可
    class func baseRequest(urlString: String!,
                           parameters: Parameters?,
                           method: HTTPMethod!,
                           isToken: Bool!,
                           requestCount: NSInteger!,
                           success: @escaping (_ responseObject: [String :Any]?)->(),
                           failure: @escaping (_ failureObject: [String :Any]?)->()) {
        
        var headers = HTTPHeaders()
        if isToken {
            let currentDate = Date()
            let timeStamp: Int = Int(currentDate.timeIntervalSince1970)
            let expireValue = kUserDefault.string(forKey: kExpireKey)
            if (expireValue == nil || Int(expireValue!)! > timeStamp) &&
                NetworkEngine.shareInstance().isGettingToken == false{
                NetworkEngine.shareInstance().netQueue.isSuspended = true
                getToken(requestCount: 0)
            }
            headers = ["authorization": kUserDefault.string(forKey: kTokenKey)] as! HTTPHeaders
        } else {
            
        }
        NetworkEngine.shareInstance().netQueue.addOperation {
            NetworkEngine.shareInstance().manager.request(urlString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    let jsonDict = JSON.init(json).dictionary
                    if jsonDict!["code"] == "0000" {
                        success(jsonDict!["data"]?.dictionary)
                    } else {
                        failure(jsonDict!["data"]?.dictionary)
                    }
                    break
                case .failure(let error):
                    if requestCount > 2 {
                        printf(error)
                        NetworkEngine.shareInstance().netQueue.cancelAllOperations()
                        return
                    } else {
                        NetworkEngine.baseRequest(urlString: urlString,
                                                  parameters: parameters,
                                                  method: method,
                                                  isToken: isToken,
                                                  requestCount: requestCount,
                                                  success: success,
                                                  failure: failure)
                    }
                    break
                }
            }
        }
    }
    
    // MARK: -  /**************** App Store 版本操作 **************************/
    // MARK: - 未完成
    class func stringWithAppStoreVersion(appURL: String) {
        let url = "http://itunes.apple.com/lookup?id=" + appURL
        Alamofire.request(URL.init(string: url)!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if let value = response.result.value {
                let json = JSON.init(value)
                if let results = json["results"][0].dictionary {
                    let onlineVersion = results["version"]?.string?.replacingOccurrences(of: ".", with: "")
                    let localVersion = kAppVersion!.replacingOccurrences(of: ".", with: "")
                    
                    if ((onlineVersion?.compare(localVersion)) != nil) {
                        let urlString = "itms-apps://itunes.apple.com/app/id\(kAppID)?mt=8"
                        let itunesURL = URL.init(string: urlString)!
                        if #available(iOS 10, *) {
                            UIApplication.shared.open(itunesURL, options: [:]) { (succsee) in
                                printf(succsee)
                            }
                        } else {
                            UIApplication.shared.openURL(itunesURL)
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: -  /**************** 网络状态监听部分 **************************/
    let reachability = Reachability()!
    deinit {
        // 关闭网络状态消息监听
        reachability.stopNotifier()
        // 移除网络状态消息通知
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: reachability)
    }
}

extension NetworkEngine {
    
    
    func NetworkStatusListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .none:
            print("网络连接：不可用")
            DispatchQueue.main.async {
                // 不加这句导致界面还没初始化完成就打开警告框，这样不行
                // 警告框，提示没有网络
            }
            break
        case .wifi:
            print("连接类型：WiFi")
            // strServerInternetAddrss = getHostAddress_WLAN() // 获取主机IP地址
            // processClientSocket(strServerInternetAddrss)    // 初始化Socket并连接，还得恢复按钮可用
            break
        case .cellular:
            print("连接类型：移动网络")
            // getHostAddrss_GPRS()  // 通过外网获取主机IP地址，并且初始化Socket并建立连接
            break
        }
    }
    
    
}






