//
//  LeftTitleTextField.swift
//  PlayCardHousekeeper
//
//  Created by Xinbo Hong on 2018/3/27.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class LeftTitleTextField: UITextField {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            
            self.font = UIFont.xb_SystemAutoFont(ofSize: 15)
            self.textColor = UIColor.black
            
            self.leftViewMode = UITextFieldViewMode.always
            self.leftView = leftLabel    
        }
    }
    
    // MARK: - Public
    public func setLeftLabelText(_ text: String) {
        if text.count > 0 {
            leftLabel.text = text
        }
    }
    
    public func setTextColor(_ color: UIColor) {
        if !color.isEqual(nil) {
            leftLabel.textColor = color
            self.textColor = color
        }
    }
    
    public func setFont(_ font: UIFont) {
        if !font.isEqual(nil) {
            leftLabel.font = font
            self.font = font
        }
    }
    // MARK: - Getter and Setter
    
    private lazy var leftLabel: UILabel = {
        var temp = UILabel.init()
        temp.frame = CGRect.init(x: 0, y: 0, width: 80, height: 40)
        temp.backgroundColor = UIColor.clear
        temp.font = self.font
        temp.textColor = self.textColor
        return temp
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
