//
//  UIColorExtention.swift
//  xb_ZRenting-Swift
//
//  Created by Xinbo Hong on 2018/2/7.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func xb_RGBColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
    
    static func xb_RGBColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    static func xb_HexColor(hex: UInt) -> UIColor {
        let r: CGFloat = CGFloat((hex & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hex & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hex & 0x0000ff)
        
        return xb_RGBColor(red: r, green: g, blue: b)
    }
    
    static func xb_HexColor(hex: String) -> UIColor {
        let hexValue = UInt(String(hex.suffix(6)), radix: 16)!
        let r: CGFloat = CGFloat((hexValue & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hexValue & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hexValue & 0x0000ff)
        
        return xb_RGBColor(red: r, green: g, blue: b)
    }
    
    static func xb_HexColor(hex: UInt, alpha: CGFloat) -> UIColor {
        let r: CGFloat = CGFloat((hex & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hex & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hex & 0x0000ff)
        
        return xb_RGBColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    static func xb_HexColor(hex: String!, alpha: CGFloat) -> UIColor {
        let hexValue = UInt(String(hex.suffix(6)), radix: 16)!
        let r: CGFloat = CGFloat((hexValue & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hexValue & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hexValue & 0x0000ff)
        
        return xb_RGBColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    static func xb_colorAt(image: UIImage, point: CGPoint) -> UIColor? {
        if CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height).contains(point) {
            return nil
        }
        let pixelData = CGDataProvider.init(data: image.cgImage! as! CFData)
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData as! CFData)
        let pixelInfo: Int = ((Int(image.size.width) * Int(point.y)) + Int(point.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo + 1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo + 2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo + 3]) / CGFloat(255.0)
        
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0)

    }
}




