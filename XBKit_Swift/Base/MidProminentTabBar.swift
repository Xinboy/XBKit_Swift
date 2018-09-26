//
//  MidProminentTabBar.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/6/8.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class MidProminentTabBar: UITabBar {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            self.shadowImage = UIImage.init()
            self.backgroundImage = UIImage.init()
            self.addSubview(midButton)
        }
    }
    
    
    public lazy var midButton: UIButton = {
        let image = UIImage.init(named: "tabbar_add")
        
        var temp = UIButton.init(type: .custom)
        temp.setImage(image, for: .normal)
        temp.frame = CGRect.init(x: (UIScreen.main.bounds.size.width - (image?.size.width)!) / 2.0, y: -(image?.size.height)! / 2.0, width: (image?.size.width)!, height: (image?.size.height)!)
        temp.adjustsImageWhenHighlighted = false
        
        return temp
    }()
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == nil {
            let tempPoint = midButton.convert(point, from: self)
            if midButton.bounds.contains(tempPoint) {
                return midButton
            }
        }
        return view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
