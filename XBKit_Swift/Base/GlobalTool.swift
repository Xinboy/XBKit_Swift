//
//  Tool.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

func printf<T>(_ message: T,
                    file: String = #file,
                    method: String = #function,
                    line: Int = #line)
{
    #if DEBUG
    print("------------------\(line) Line Begin-------------------------\n类名称: \((file as NSString).lastPathComponent)\n方法名: \(method)\n信息: \(message)\n------------------\(line) Line End-------------------------")
    #endif
}

func showSubviewsLevel(view: UIView, level: NSInteger) {
    let subviews = view.subviews
    
    if subviews.count == 0 {
        return
    }
    for sub: UIView in subviews {
        var blank = ""
        for _ in 0..<level {
            blank = " " + blank
        }
        let str = blank + String(level) + ":" + sub.description
        print(str)
        showSubviewsLevel(view: sub, level: level + 1)
    }
}

func showAllFonts() {
    let familyNames = UIFont.familyNames
    for familyName in familyNames {
        let fontNames = UIFont.fontNames(forFamilyName: familyName)
        for fontName in fontNames {
            print("\tFont: \(fontName.utf8)")
        }
    }
}







