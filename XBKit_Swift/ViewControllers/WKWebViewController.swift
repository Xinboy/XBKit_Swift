//
//  WKWebViewController.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/6/8.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit
import WebKit
class WKWebViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let webView = WKWebView.init(frame: UIScreen.main.bounds)
        let url = URL.init(string: "http://www.jianshu.com")
        let request = NSURLRequest.init(url: url!)
        webView.load(request as URLRequest)
        view.addSubview(webView)
        printf("-----")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
