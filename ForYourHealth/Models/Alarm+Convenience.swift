//
//  Alarm+Convenience.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/9/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

extension Alarm{
    var fireTimeAsString: String {
        return (fireDate?.toStringWith(dateStyle: .none, timeStyle: .short))!
    }
    
    convenience init(withUser user: User, name:String, enabled:Bool = true, fireDate:Date,uuid: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.fireDate = fireDate
        self.user = user
        self.enabled = enabled
        self.uuid = uuid
        self.name = name
        
    }
    
    convenience init(withMedication medication: MedIcation, enabled:Bool = true, fireDate:Date,uuid: String = UUID().uuidString, name:String, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.fireDate = fireDate
        self.medication = medication
        self.enabled = enabled
        self.uuid = uuid
        self.name = name
        
    }
}
