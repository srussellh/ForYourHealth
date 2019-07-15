//
//  Entry+Convenience.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/9/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    convenience init(body:String, timeStamp:Date, user:User, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.body = body
        self.timeStamp = timeStamp
        self.user = user
    }
}
