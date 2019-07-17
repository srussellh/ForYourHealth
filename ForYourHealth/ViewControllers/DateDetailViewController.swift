//
//  DateDetailViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/16/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit
import CoreData

class DateDetailViewController: UIViewController {

    var monthPassed = Int()
    var year = Int()
    var day = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.day = day
        components.year = year
        components.month = monthPassed
        let date = calendar.date(from: components)
        print(date!)
        
    }
    
//    var entries: [Entry]{
//        let moc = CoreDataStack.context
//        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
//        let result = (try? moc.fetch(fetchRequest))
//        return result ?? []
//    }
//
//    var symptoms: [Symptom]{
//        let moc = CoreDataStack.context
//        let fetchRequest: NSFetchRequest<Symptom> = Symptom.fetchRequest()
//        let result = (try? moc.fetch(fetchRequest))
//        return result ?? []
//    }
//    var foodEntries: [FoodEntry]{
//        let moc = CoreDataStack.context
//        let fetchRequest: NSFetchRequest<FoodEntry> = FoodEntry.fetchRequest()
//        let result = (try? moc.fetch(fetchRequest))
//        return result ?? []
//    }
    
    func fetchEntry(date:Date) -> [Entry]{
        let moc = CoreDataStack.context
        let entryFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        entryFetch.predicate = NSPredicate(format: "timeStamp == %@", date as NSDate)
        do {
            let fetchedEntries = try moc.fetch(entryFetch) as! [Entry]
            let entries = fetchedEntries
            return entries
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }

    func fetchSymptoms(date:Date) -> [Symptom]{
        let moc = CoreDataStack.context
        let symptomsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Symptom")
        symptomsFetch.predicate = NSPredicate(format: "timeStamp == %@", date as NSDate)
        do {
            let fetchedSymptoms = try moc.fetch(symptomsFetch) as! [Symptom]
            let symptoms = fetchedSymptoms
            return symptoms
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }

    }

    func fetchFoodEntry(date:Date) -> [FoodEntry]{
        let moc = CoreDataStack.context
        let foodEntriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodEntry")
        foodEntriesFetch.predicate = NSPredicate(format: "timeStamp == %@", date as NSDate)
        do {
            let fetchedFoodEntries = try moc.fetch(foodEntriesFetch) as! [FoodEntry]
            let foodEntries = fetchedFoodEntries
            return foodEntries
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
}
