//
//  PointView.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/6/11.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class PointView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var selectedColor = UIColor()
    var ID: String = ""
    var contentLayer = CAShapeLayer()
    var borderLayer = CAShapeLayer()
    var centerLayer = CAShapeLayer()
    
    
    func inits(frame: CGRect, ID: String) {
        self.ID = ID
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            
        }
    }
}
