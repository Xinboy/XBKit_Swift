//
//  Array+Extention.swift
//  XBProjectModule-Swift
//
//  Created by Xinbo Hong on 2018/4/11.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation

extension Array {
    func xb_GetIndexOfRemove<T: Equatable>(value: T) -> [Int] {
        var indexArray = [Int]()
        var correctArray = [Int]()
        
        for (index, _) in self.enumerated() {
            if self[index] as! T == value {
                indexArray.append(index)
            }
        }
        for (index, originIndex) in indexArray.enumerated() {
            let correctIndex = originIndex - index
            correctArray.append(correctIndex)
        }
        return correctArray
    }
    
    mutating func removeObject<T: Equatable>(value: T) {
        let correctArray = self.xb_GetIndexOfRemove(value: value)
        for index in correctArray {
            self.remove(at: index)
        }
    }
}
