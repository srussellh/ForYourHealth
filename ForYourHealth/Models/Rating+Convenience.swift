//
//  Rating+Convenience.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/9/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

extension Rating{
    convenience init(number: String, timeStamp: Date = Date(), symptom: Symptom, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.number = number
        self.timeStamp = timeStamp
        self.symptom = symptom
    }
}
