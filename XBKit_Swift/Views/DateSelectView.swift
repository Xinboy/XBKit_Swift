//
//  DateSelectView.swift
//  PlayCardHousekeeper
//
//  Created by Xinbo Hong on 2018/3/26.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class DateSelectView: UIView {

    private struct Color {
        static let titleColor = UIColor.darkGray
        static let textBgColor = UIColor.darkGray
        static let textColor = UIColor.white
        static let bgColor = UIColor.white
    }

    typealias BackDateStringBlock = (String) -> ()
    var backDateStringBlock: BackDateStringBlock!
    
    /* 101代表开始时间，102代表结束时间*/
    private var selectedLabelIndex = 0
    private var dateFormatter = DateFormatter.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            self.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
            self.dateFormatter.dateFormat = "yyyy/MM/dd"
            
            self.addSubview(showView)
            self.addSubview(datePicker)
            showView.addSubview(titleLabel)
            showView.addSubview(lineLabel)
            showView.addSubview(startLabel)
            showView.addSubview(startTimeLabel)
            showView.addSubview(endLabel)
            showView.addSubview(endTimeLabel)
            showView.addSubview(cancelButton)
            showView.addSubview(confirmButton)
            
            self.setupAutoLayout()
            self.setTimeText()
            
        }
    }
    
    // MARK: - public
    func backDateStringBlockFunction(block: @escaping (String) -> ()) {
        self.backDateStringBlock = block
    }
    
    func setTitle(topLabel firStr: String, bottomLabel secStr: String) {
        if firStr.count > 0 {
            startLabel.text = firStr
        }
        if secStr.count > 0 {
            endLabel.text = firStr
        }
    }
    // MARK: - private
    private func setTimeText() {
        let startDate = Date.xb_StartOfCurrentMonth()
        let endDate = Date.xb_EndOfCurrentMonth()

        startTimeLabel.text = dateFormatter.string(from: startDate)
        endTimeLabel.text = dateFormatter.string(from: endDate)
    }
    
    @objc func datePickerValueChange(sender: UIDatePicker) {
        let selectedDate = sender.date
        
        if selectedLabelIndex == 101 {
            startTimeLabel.text = dateFormatter.string(from: selectedDate)
        } else if selectedLabelIndex == 102 {
            endTimeLabel.text = dateFormatter.string(from: selectedDate)
        }
    }
    
    @objc func cancelAction(sender: UIButton) {
        self.isHidden = true
        datePicker.snp.updateConstraints({ (make) in
            make.bottom.equalTo(self).offset(216)
        })
        self.layoutIfNeeded()
    }
    
    @objc func confirmAction(sender: UIButton) {
        
        let startDate = dateFormatter.date(from: startTimeLabel.text!)!
        let endDate = dateFormatter.date(from: endTimeLabel.text!)!
        if startDate.compare(endDate) != .orderedAscending {
            //开始日期大于结束日期
            return
        }
        
        self.isHidden = true
        datePicker.snp.updateConstraints({ (make) in
            make.bottom.equalTo(self).offset(216)
        })
        self.layoutIfNeeded()
        
        if backDateStringBlock != nil {
            let str = "\(self.startTimeLabel.text!) ~ \(self.endTimeLabel.text!)"
            backDateStringBlock(str)
        }
    }
    
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: Any in touches {
            let t: UITouch = touch as! UITouch
            let point = t.location(in: showView)
            
            if startTimeLabel.frame.contains(point) {
                selectedLabelIndex = 101
                datePicker.setDate(dateFormatter.date(from: startTimeLabel.text!)!, animated: true)
            } else if endTimeLabel.frame.contains(point) {
                selectedLabelIndex = 102
                datePicker.setDate(dateFormatter.date(from: endTimeLabel.text!)!, animated: true)
            } else {
                return
            }
            UIView.animate(withDuration: 0.5) {
                self.datePicker.snp.updateConstraints({ (make) in
                    make.bottom.equalTo(self.snp.bottom)
                })
                self.layoutIfNeeded()
            }
        }
    }
    
    
    private func setupAutoLayout() {
        
        let betSpace = 5
        let basedHeight = 35
        showView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-50)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(showView)
            make.height.equalTo(40)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(showView)
            make.height.equalTo(1)
        }
        
        startLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineLabel.snp.bottom).offset(betSpace)
            make.left.right.equalTo(showView)
            make.height.equalTo(20)
        }
        
        startTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startLabel.snp.bottom).offset(betSpace)
            make.left.equalTo(showView).offset(45)
            make.right.equalTo(showView).offset(-45)
            make.height.equalTo(basedHeight)
        }
        
        endLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startTimeLabel.snp.bottom).offset(betSpace)
            make.left.right.equalTo(showView)
            make.height.equalTo(startLabel.snp.height)
        }
        
        endTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(endLabel.snp.bottom).offset(betSpace)
            make.left.equalTo(startTimeLabel.snp.left)
            make.right.equalTo(startTimeLabel.snp.right)
            make.height.equalTo(basedHeight)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(endTimeLabel.snp.bottom).offset(25)
            make.left.equalTo(endTimeLabel.snp.left)
            make.height.equalTo(30)
            make.bottom.equalTo(showView.snp.bottom).offset(-10)
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(cancelButton)
            make.left.equalTo(cancelButton.snp.right).offset(20)
            make.right.equalTo(endTimeLabel.snp.right)
            make.size.equalTo(cancelButton.snp.size)
            make.bottom.equalTo(cancelButton)
        }
        
        datePicker.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(216)
            make.bottom.equalTo(self).offset(216)
        }
    }
    
    // MARK: - Getter and setter
    private lazy var showView: UIView = {
       var temp = UIView.init()
        temp.backgroundColor = Color.bgColor
        return temp
    }()
    
    private lazy var titleLabel: UILabel = {
        var temp = UILabel.init()
        temp.textAlignment = .center
        temp.textColor = Color.titleColor
        temp.text = "请选择日期范围"
        temp.font = UIFont.xb_SystemAutoFont(ofSize: 18)
        return temp
    }()
    
    private lazy var lineLabel: UILabel = {
        var temp = UILabel.init()
        temp.backgroundColor = UIColor.black
        return temp
    }()
    
    private lazy var startLabel: UILabel = {
        var temp = UILabel.init()
        temp.textAlignment = .center
        temp.textColor = Color.titleColor
        temp.text = "开始日期"
        temp.font = UIFont.xb_SystemAutoFont(ofSize: 18)
        return temp
    }()
    
    private lazy var startTimeLabel: UILabel = {
        var temp = UILabel.init()
        temp.textAlignment = .center
        temp.textColor = Color.textColor
        temp.backgroundColor = Color.textBgColor
        temp.font = UIFont.xb_SystemAutoFont(ofSize: 18)
        return temp
    }()
    
    private lazy var endLabel: UILabel = {
        var temp = UILabel.init()
        temp.textAlignment = .center
        temp.textColor = Color.titleColor
        temp.text = "结束日期"
        temp.font = UIFont.xb_SystemAutoFont(ofSize: 18)
        return temp
    }()
    
    private lazy var endTimeLabel: UILabel = {
        var temp = UILabel.init()
        temp.textAlignment = .center
        temp.textColor = Color.textColor
        temp.backgroundColor = Color.textBgColor
        temp.font = UIFont.xb_SystemAutoFont(ofSize: 18)
        return temp
    }()
    
    private lazy var cancelButton: UIButton = {
        var temp = UIButton.init(type: UIButtonType.custom)
        temp.setTitle("取消", for: .normal)
        temp.setTitleColor(Color.textColor, for: .normal)
        temp.setBackgroundImage(UIImage.xb_imageWithColor(color: Color.textBgColor), for: .normal)
        temp.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return temp
    }()
    
    private lazy var confirmButton: UIButton = {
        var temp = UIButton.init(type: UIButtonType.custom)
        temp.setTitle("确定", for: .normal)
        temp.setTitleColor(Color.textColor, for: .normal)
        temp.setBackgroundImage(UIImage.xb_imageWithColor(color: Color.textBgColor), for: .normal)
        temp.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        return temp
    }()
    
    private lazy var datePicker: UIDatePicker = {
        var temp = UIDatePicker.init()
        
//        temp.frame = CGRect.init(x: 0.0, y: kScreenHeight, width: kScreenWidth, height: 216.0)
        temp.locale = Locale.init(identifier: "zh_CN")
        temp.backgroundColor = Color.bgColor
        temp.datePickerMode = .date
        temp.addTarget(self, action: #selector(datePickerValueChange), for: .valueChanged)
        
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


