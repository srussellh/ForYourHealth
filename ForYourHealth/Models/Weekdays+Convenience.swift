//
//  Weekdays+Convenience.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

extension Weekdays {
    @discardableResult convenience init(alarm: Alarm, weekday: Int, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.weekdayInt = Int64(weekday)
        self.alarm = alarm
    }
}
