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
        
        view.backgroundColor = lightShade
        segmentController.tintColor = darkAccent
        displayTable.backgroundColor = lightShade
        displayTable.layer.cornerRadius = textFieldRounder
        components.day = day
        components.year = year
        components.month = monthPassed
        guard let date = calendar.date(from: components) else {return}
        
        fetchEntry(date: date)
        fetchRatings(date: date)
        fetchFoodEntry(date: date)
        
        let titleLabel = UILabel()
        titleLabel.text = date.monthDay
        titleLabel.font = headerFont
        titleLabel.textColor = darkShade
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        
    }
    override func viewWillAppear(_ animated: Bool) {
        displayTable.reloadData()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch segmentIndex {
            case 1:
                guard let entryToDelete = entriesList?[indexPath.row] else {return}
                entriesList?.remove(at: indexPath.row)
                EntryController.shared.deleteEntry(entry: entryToDelete)
            case 2:
                guard let ratingToDelete = ratingsList?[indexPath.row] else {return}
                ratingsList?.remove(at: indexPath.row)
                RatingController.shared.deleteRating(rating: ratingToDelete)
            case 3:
                guard let foodEntryToDelete = foodEntriesList?[indexPath.row] else {return}
                foodEntriesList?.remove(at: indexPath.row)
                FoodEntryController.shared.deleteFoodEntry(foodEntry: foodEntryToDelete)
            default:
                return
            }
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentIndex {
        case 1:
            performSegue(withIdentifier: "toEditEntry", sender: nil)
        case 2:
            performSegue(withIdentifier: "toEditRating", sender: nil)
        case 3:
            performSegue(withIdentifier: "toEditFoodEntry", sender: nil)
        default:
            performSegue(withIdentifier: "toEditFoodEntry", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditEntry" {
            guard let indexPath = displayTable.indexPathForSelectedRow,
                let entriesList = entriesList,
                let destinationVC = segue.destination as? EditEntryViewController else {return}
            destinationVC.entry = entriesList[indexPath.row]
        } else if segue.identifier == "toEditRating"{
            guard let indexPath = displayTable.indexPathForSelectedRow,
            let ratingsList = ratingsList,
                let destinationVC = segue.destination as? EditRatingViewController else {return}
            destinationVC.rating = ratingsList[indexPath.row]
        } else {
            guard let indexPath = displayTable.indexPathForSelectedRow,
            let foodEntriesList = foodEntriesList,
                let destinationVC = segue.destination as? EditFoodEntryViewController else {return}
            destinationVC.foodEntry = foodEntriesList[indexPath.row]
        }
    }
}
