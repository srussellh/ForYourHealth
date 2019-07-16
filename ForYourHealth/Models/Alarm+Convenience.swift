//
//  Alarm+Convenience.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/9/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

extension Alarm {
    
    
    convenience init(withUser user: User, name:String, enabled:Bool = true, hour:Int, minute:Int, amOrPm: Int, weekdays:[Int], uuid: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.hour = Int64(hour)
        self.minute = Int64(minute)
        self.amOrPm = Int64(amOrPm)
        self.enabled = enabled
        self.uuid = uuid
        self.name = name
        self.weekdays = weekdays.map { Int64($0) }
        
    }
    
    convenience init(withMedication medication: MedIcation, enabled:Bool = true,uuid: String = UUID().uuidString, hour:Int, minute:Int, amOrPm: Int, weekdays:[Int], name:String, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.hour = Int64(hour)
        self.minute = Int64(minute)
        self.amOrPm = Int64(amOrPm)
        self.medication = medication
        self.enabled = enabled
        self.uuid = uuid
        self.name = name
        self.weekdays = weekdays.map { Int64($0) }
        
    }
}
