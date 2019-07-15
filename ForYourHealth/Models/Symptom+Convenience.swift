//
//  Symptom+Convenience.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/9/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

extension Symptom {
    @discardableResult convenience init(detail: String, user: User, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.detail = detail
        self.user = user
    }
}
