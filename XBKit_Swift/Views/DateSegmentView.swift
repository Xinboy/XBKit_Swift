//
//  DateSegment.swift
//  PlayCardHousekeeper
//
//  Created by Xinbo Hong on 2018/3/7.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit
enum DateRange: Int {
    case Custom = 0
    case Month
    case HalfYear
    case Year
    
}

class DateSegmentView: UIView {

    private let textColor = UIColor.xb_HexColor(hex: 0x1B2631)
    private var lastSelectedIndex = 1
    
    typealias ShowDataWithDateRange = (_ startDate: Date,_ endDate:Date) -> ()
    var showDateBlock: ShowDataWithDateRange!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            self.addSubview(timeLable)
            self.addSubview(segmentedControl)
            
            let window = UIApplication.shared.keyWindow
            window?.addSubview(dateSelectView)
            
            self.setupAutoLayout()
        }
    }
    
    @objc func onChange(sender: UISegmentedControl) {
        
        var startDate = Date()
 
        switch sender.selectedSegmentIndex {
        case DateRange.Custom.hashValue:
            if dateSelectView.isHidden {
                dateSelectView.isHidden = false
            } else {
                dateSelectView.isHidden = true
            }
            dateSelectView.backDateStringBlockFunction(block: { (timeStr) in
                self.timeLable.text = timeStr
            })
            segmentedControl.selectedSegmentIndex = lastSelectedIndex
            return
        case DateRange.Month.hashValue:
            startDate = Date.xb_StartOfCurrentMonth()
            break
        case DateRange.HalfYear.hashValue:
            startDate = Date.xb_StartBeforeHalfYear()
            break
        case DateRange.Year.hashValue:
            startDate = Date.xb_StartBeforeYear()
            break
        default:
            break
        }
        
        let endDate = Date.xb_EndOfCurrentMonth()
        let dateFormatter = DateFormatter()
        lastSelectedIndex = sender.selectedSegmentIndex
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        timeLable.text = "\(dateFormatter.string(from: startDate)) ~ \(dateFormatter.string(from: endDate))"
        
        if showDateBlock != nil {
            showDateBlock!(startDate, endDate)
        }
        
    }
    func showDateBlockFunction(block: @escaping (_ startDate: Date, _ endDate:Date) -> ()) {
        self.showDateBlock = block
    }
    
    private func setupAutoLayout() {
        timeLable.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(25)
        })
    
        segmentedControl.snp.makeConstraints({ (make) in
            make.top.equalTo(timeLable.snp.bottom).offset(4)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(30)
        })
    
    }
    
    // MARK: - Getter and setter
    private lazy var dateSelectView: DateSelectView = {
        var temp = DateSelectView.init(frame: UIScreen.main.bounds)
        temp.isHidden = true
        return temp
    }()
    
    private lazy var timeLable: UILabel = {
        var temp = UILabel.init()
        temp.textColor = textColor
        temp.textAlignment = .center
        temp.font = UIFont.xb_SystemAutoFont(ofSize: 15)
        
        return temp
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentItems = ["自定义", "月", "半年", "年"]
        
        var temp = UISegmentedControl.init(items: segmentItems)
        temp.tintColor = UIColor.gray
        temp.backgroundColor = UIColor.clear
        temp.selectedSegmentIndex = DateRange.Month.hashValue
        
        let startDate = Date.xb_StartOfCurrentMonth()
        let endDate = Date.xb_EndOfCurrentMonth()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        timeLable.text = "\(dateFormatter.string(from: startDate)) ~ \(dateFormatter.string(from: endDate))"
        
        temp.addTarget(self, action: #selector(onChange), for: .valueChanged)
        
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
