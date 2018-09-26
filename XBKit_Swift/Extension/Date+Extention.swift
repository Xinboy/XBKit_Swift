//
//  Date+Extention.swift
//  PlayCardHousekeeper
//
//  Created by Xinbo Hong on 2018/3/8.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

extension Date {
    
    static func stringTimeStampWithCurrentDate() -> String {
        let date = Date()
        return String(date.timeIntervalSince1970)
    }
    
    static func intTimeStampWithCurrentDate() -> Int {
        let date = Date()
        return Int(date.timeIntervalSince1970)
    }
    
    static func xb_StartBeforeHalfYear() -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        let current = xb_GetYearAndMonth(date: xb_StartOfCurrentMonth())
        if current.Month < 6 {
            startComps.year = current.Year - 1
        }
        startComps.month = (6 + current.Month) % 12 + 1
        startComps.day = 1
        
        let startDate = calendar.date(from: startComps)!
        return startDate
        
    }
    
    static func xb_StartBeforeYear() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        var components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        components.year = components.year! - 1
        let startOfMonth = calendar.date(from: components)!
        
        return startOfMonth
    }
    
    static func xb_StartOfCurrentMonth() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        let startDate = calendar.date(from: components)!
        return startDate
    }
    
    static func xb_EndOfCurrentMonth() -> Date {
        let calendar = NSCalendar.current
        
        var components = DateComponents()
        components.month = 1
        components.hour = -1
        let endDate =  calendar.date(byAdding: components, to: xb_StartOfCurrentMonth())!
        return endDate
    }
    
    static func xb_StartOfMonth(year: Int, month: Int) -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps)!
        return startDate
    }
    
    static func xb_GetYearAndMonth(date: Date) -> (Year: Int, Month: Int) {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        return (components.year!, components.month!)
    }
}

