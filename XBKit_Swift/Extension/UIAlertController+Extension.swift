//
//  UIAlertController+Extension.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation
import UIKit
extension UIAlertController {
    struct KVOKey {
       static let AttributedMessage = "attributedMessage"
       static let AttributedTitle = "attributedTitle"
    }
    
    func xb_setAlertControllerTitle(alertController: UIAlertController, alignment: NSTextAlignment) {
        let subView1 = alertController.view.subviews[0];
        let subView2 = subView1.subviews[0];
        let subView3 = subView2.subviews[0];
        let subView4 = subView3.subviews[0];
        let subView5 = subView4.subviews[0];
        let title: UILabel = subView5.subviews[0] as! UILabel;
        title.textAlignment = alignment;
    }
    
    func xb_setAlertControllerMessage(alertController: UIAlertController, alignment: NSTextAlignment) {
        let subView1 = alertController.view.subviews[0];
        let subView2 = subView1.subviews[0];
        let subView3 = subView2.subviews[0];
        let subView4 = subView3.subviews[0];
        let subView5 = subView4.subviews[0];
        let message: UILabel = subView5.subviews[1] as! UILabel;
        message.textAlignment = alignment;
    }

}
