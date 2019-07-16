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
    @discardableResult convenience init(weekday: Int16, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.weekdayInt = weekday
    }
}
