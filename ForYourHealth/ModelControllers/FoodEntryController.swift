//
//  FoodEntryController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

class FoodEntryController {
    static let shared = FoodEntryController ()
    
    func createFoodEntry(meal: String, detail: String, user: User){
        FoodEntry(details: detail, meal: meal, user: user)
        UserController.shared.saveToPersistentStore()
    }
    
    func updateFoodEntry(foodEntry: FoodEntry, meal: String, detail: String){
        foodEntry.meal = meal
        foodEntry.details = detail
        UserController.shared.saveToPersistentStore()
    }
    
    func deleteFoodEntry(foodEntry: FoodEntry){
        let moc = CoreDataStack.context
        moc.delete(foodEntry)
        UserController.shared.saveToPersistentStore()
    }
}
