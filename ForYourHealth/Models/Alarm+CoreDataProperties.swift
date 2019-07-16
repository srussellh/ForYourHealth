//
//  Alarm+CoreDataProperties.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/16/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var amOrPm: Int64
    @NSManaged public var enabled: Bool
    @NSManaged public var hour: Int64
    @NSManaged public var minute: Int64
    @NSManaged public var name: String?
    @NSManaged public var uuid: String?
    @NSManaged public var medication: MedIcation?
    @NSManaged public var user: User?
    @NSManaged public var weekdays: [Int64]

}

