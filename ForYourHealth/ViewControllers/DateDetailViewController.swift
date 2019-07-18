//
//  DateDetailViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/16/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit
import CoreData

class DateDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    var monthPassed = Int()
    var year = Int()
    var day = Int()
    var entriesList: [Entry]?
    var ratingsList: [Rating]?
    var foodEntriesList: [FoodEntry]?
    var segmentIndex = 1
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var displayTable: UITableView!
    @IBOutlet weak var headerLabel: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.day = day
        components.year = year
        components.month = monthPassed
        guard let date = calendar.date(from: components) else {return}
        headerLabel.title = date.monthDay
        fetchEntry(date: date)
        fetchRatings(date: date)
        fetchFoodEntry(date: date)
        
    }
    
    @IBAction func segmentControllerChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentIndex = 1
            displayTable.reloadData()
        case 1:
            segmentIndex = 2
            displayTable.reloadData()
        case 2:
            segmentIndex = 3
            displayTable.reloadData()
        default:
            segmentIndex = 1
            displayTable.reloadData()
        }
    }
    
    
    
    func fetchEntry(date:Date) {
        let moc = CoreDataStack.context
        let entryFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        entryFetch.predicate = NSPredicate(format: "timeStamp == %@", date.atNoon() as NSDate)
        do {
            let fetchedEntries = try moc.fetch(entryFetch) as! [Entry]
            let entries = fetchedEntries
            entriesList = entries
        } catch {
            fatalError("Failed to fetch Entries: \(error)")
        }
    }

    func fetchRatings(date:Date) {
        let moc = CoreDataStack.context
        let ratingsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Rating")
        ratingsFetch.predicate = NSPredicate(format: "timeStamp == %@", date.atNoon() as NSDate)
        do {
            let fetchedSymptoms = try moc.fetch(ratingsFetch) as! [Rating]
            let rating = fetchedSymptoms
            ratingsList = rating
        } catch {
            fatalError("Failed to fetch Symptoms: \(error)")
        }

    }

    func fetchFoodEntry(date:Date) {
        let moc = CoreDataStack.context
        let foodEntriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodEntry")
        foodEntriesFetch.predicate = NSPredicate(format: "timeStamp == %@", date.atNoon() as NSDate)
        do {
            let fetchedFoodEntries = try moc.fetch(foodEntriesFetch) as! [FoodEntry]
            let foodEntries = fetchedFoodEntries
            foodEntriesList = foodEntries
        } catch {
            fatalError("Failed to fetch FoodEntries: \(error)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentIndex {
        case 1:
            guard let entriesCount = entriesList?.count else {return 0}
            return entriesCount
        case 2:
            guard let ratingsCount = ratingsList?.count else {return 0}
            return ratingsCount
        case 3:
            guard let foodEntriesCount = foodEntriesList?.count else {return 0}
            return foodEntriesCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DateDetailTableViewCell else {return UITableViewCell()}
        switch segmentIndex {
        case 1:
            guard let entries = entriesList else {return UITableViewCell()}
            cell.titleLabel.text = entries[indexPath.row].body
            cell.ratingLabel.text = ""
            return cell
        case 2:
           guard let ratings = ratingsList else {return UITableViewCell()}
            cell.titleLabel.text = ratings[indexPath.row].symptom?.detail
            cell.ratingLabel.text = ratings[indexPath.row].number
            return cell
        case 3:
            guard let foodEntries = foodEntriesList else {return UITableViewCell()}
            cell.titleLabel.text = foodEntries[indexPath.row].details
            cell.ratingLabel.text = ""
            return cell
        default:
            guard let entries = entriesList else {return UITableViewCell()}
            cell.titleLabel.text = entries[indexPath.row].body
            cell.ratingLabel.text = ""
            return cell
        }
    }
}
