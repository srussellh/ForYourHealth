//
//  User+Convenience.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/9/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

extension User {
    @discardableResult convenience init(name:String, ifYouKnow:Bool = false, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.name = name
        self.ifYouKnow = ifYouKnow
    }
}
