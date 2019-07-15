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
    convenience init(withUser time:Date, user: User, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.time = time
        self.user = user
    }
    convenience init(withMedication time:Date, medication: MedIcation, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.time = time
        self.medication = medication
    }
}
