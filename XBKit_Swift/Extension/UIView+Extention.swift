//
//  UIView+Extention.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func setCornerRadius(radius: CGFloat, rectCorner: UIRectCorner) {
        self.layoutIfNeeded()
        
        let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize.init(width: radius, height: radius))
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    func setCornerRadiusShadow(offset: CGFloat, cornerRadius: CGFloat) -> CALayer {
        let shadowLayer = CALayer.init()
        shadowLayer.shadowOffset = CGSize.init(width: 0, height: 3)
        shadowLayer.shadowRadius = 5.0;
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOpacity = 0.1;
        shadowLayer.cornerRadius = cornerRadius
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        shadowLayer.addSublayer(self.layer)
        
        return shadowLayer
        
    }
}
