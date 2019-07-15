//
//  FoodEntry+Convenience.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/9/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

extension FoodEntry {
    convenience init(details: String, meal:String, timeStamp: Date, user:User, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.details = details
        self.meal = meal
        self.timeStamp = timeStamp
        self.user = user
    }
}
