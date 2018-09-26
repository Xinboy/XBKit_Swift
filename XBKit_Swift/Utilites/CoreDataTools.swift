//
//  CoreDataTools.swift
//  PlayCardHousekeeper
//
//  Created by Xinbo Hong on 2018/3/7.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTools: NSObject {
    
    static func fetchDataFromCoreData(entityName:String, whereStr:String) -> Array<Any> {
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        
        if whereStr != "" {
            let predicate = NSPredicate(format: whereStr)
            request.predicate = predicate
        }
        
        let context = AppDelegate().managedObjectContext
        do {
            return (try context.fetch(request) as? [NSManagedObject])!
        } catch let error {
            printf("Fetch error:\(error)")
        }
        return []
    }
    
    static func deleteContext(object: NSManagedObject) {
        let context = AppDelegate().managedObjectContext
        
        context.delete(object)
        
        AppDelegate().saveContext()
    }
    
    static func insertData(entityName:String, data:[String:Any]) {
        let context = AppDelegate().managedObjectContext
        
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)

        for (key, value) in data {
            managedObject.setValue(value, forKey: key)
        }
        
        AppDelegate().saveContext()
    }

}
