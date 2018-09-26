//
//  UIFont+Extention.swift
//  XBZRenting-Swift
//
//  Created by Xinbo Hong on 2018/2/14.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    ///根据设备类型，自适应标准字体大小
    static func xb_SystemAutoFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize:self.xb_AutolayoutFontSize(fontSize: ofSize))
    }
    
    ///根据设备类型，自适应粗体字体大小
    static func xb_BoldSystemAutoFont(ofSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize:self.xb_AutolayoutFontSize(fontSize: ofSize))
    }
    
    ///根据设备类型，自适应字体大小
    static func xb_font(fontName:String, ofSize: CGFloat) -> UIFont {
        return UIFont.init(name: fontName, size: self.xb_AutolayoutFontSize(fontSize: ofSize))!
    }
    
    ///根据设备类型，自适应字体大小
    private static func xb_AutolayoutFontSize(fontSize: CGFloat) -> CGFloat {
        let type = UIDevice.xb_PhoneTypeWithCurrentDevice()
        switch type {
        case .Defualt:
            return fontSize
        case .SE:
            return fontSize - 2
        case .Plus:
            return fontSize + 2
        case .X:
            return fontSize + 2
        
        }
    }
}
