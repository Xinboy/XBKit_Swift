//
//  UIButton+Extention.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    enum SubviewsAligment: NSInteger {
        /** 默认*/
        case normal = 0
        /** 文字左边 图片右边 左对齐*/
        case titleLeft
        /** 文字左边 图片右边 两端对齐*/
        case titleJustified
        /** 文字左边 图片右边 右对齐*/
        case titleRight
        /** 图片左边 文字右边 左对齐*/
        case imageLeft
        /** 图片左边 文字右边 两端对齐*/
        case imageJustified
        /** 图片左边 文字右边 右对齐*/
        case imageRight
        /** 图片左边 文字右边 居中对齐*/
        case imageCenterLeft
        /** 文字左边 图片右边 居中对齐*/
        case imageCenterRight
        /** 文字下边 图片上边 居中对齐*/
        case imageCenterTop
        /** 文字上边 图片下边 居中对齐*/
        case imageCenterBottom
    }
    
    func xb_resetSubviews(alignment: SubviewsAligment, interval: CGFloat) {
        if self.imageView?.image != nil && self.titleLabel?.text != nil {
            self.titleEdgeInsets = UIEdgeInsets.zero
            self.imageEdgeInsets = UIEdgeInsets.zero
            
            let labelX = self.titleLabel?.frame.origin.x;
            let labelWidth = self.titleLabel?.frame.size.width;
            let labelHeight = self.titleLabel?.frame.size.height;
            let imageX = self.imageView?.frame.origin.x;
            let imageViewWidth = self.imageView?.frame.size.width;
            let imageViewHeight = self.imageView?.frame.size.height;
            let buttonWidth = self.frame.size.width;
            
            
            switch alignment {
            case .normal:
                break
            case .titleLeft:
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -(imageX! - interval) + labelWidth!, bottom: 0, right: (imageX! - interval) - labelWidth!)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(labelX! - interval), bottom: 0, right: labelX! - interval)
                break
            case .titleJustified:
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: buttonWidth - (imageX! + imageViewWidth! + interval), bottom: 0, right: -(buttonWidth - (imageX! + imageViewWidth! + interval)))
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left:  -(labelX! - interval), bottom: 0, right: labelX! - interval)
                break
            case .titleRight:
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: buttonWidth - imageX! - imageViewWidth! - interval, bottom: 0, right: -(buttonWidth - imageX! - imageViewWidth! - interval))
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left:  buttonWidth - (labelX! + labelWidth! + interval) - imageViewWidth!, bottom: 0, right: -(buttonWidth - (labelX! + labelWidth! + interval)) + imageViewWidth!)
                break
            case .imageLeft:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -imageX! + interval, 0, imageX! + interval)
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageX! + interval, 0, imageX! + interval)
                break
            case .imageJustified:
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -(imageX! - interval), bottom: 0, right: imageX! - interval)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: buttonWidth - (labelX! + labelWidth! + interval), bottom: 0, right: -(buttonWidth - (labelX! + labelWidth! + interval)))
                break
            case .imageRight:
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: buttonWidth - (labelX! + labelWidth! + interval), bottom: 0, right: -(buttonWidth - (labelX! + labelWidth! + interval)))
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: buttonWidth - (labelX! + labelWidth! + interval), bottom: 0, right: -(buttonWidth - (labelX! + labelWidth! + interval)))
            case .imageCenterLeft:
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: interval, bottom: 0, right: 0)
                break
            case .imageCenterRight:
                self.contentVerticalAlignment = .center
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: labelWidth!, bottom: 0, right: labelWidth!)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(imageViewWidth! + interval), bottom: 0, right: imageViewWidth!)
                break
            case .imageCenterTop:
                self.contentVerticalAlignment = .center
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: labelWidth! / 2, bottom: labelHeight! + interval, right: -labelWidth! / 2)
                self.titleEdgeInsets = UIEdgeInsets.init(top: imageViewHeight! + interval, left: -labelWidth!, bottom: 0, right: 0)
            case .imageCenterBottom:
                self.contentVerticalAlignment = .center
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: labelWidth! / 2, bottom: -(labelHeight! + interval), right: -labelWidth! / 2)
                self.titleEdgeInsets = UIEdgeInsets.init(top: -(imageViewHeight! + interval), left: imageViewWidth!, bottom: 0, right: labelWidth!)
                break
            }
        } else {
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func xb_resetSubviews(alignment: SubviewsAligment) {
        self.xb_resetSubviews(alignment: alignment, interval: 5.0)
    }
}





