//
//  CalenderViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonth = String()
    var currentYear = year
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var previousNumberOfEmptyBox = 0
    var direction = 0
    var positionIndex = 0

    @IBOutlet weak var calender: UICollectionView!
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var rightArrowButton: UIButton!
    
    @IBOutlet weak var sunLabel: UILabel!
    @IBOutlet weak var monLabel: UILabel!
    @IBOutlet weak var tueLabel: UILabel!
    @IBOutlet weak var wedLabel: UILabel!
    @IBOutlet weak var thurLabel: UILabel!
    @IBOutlet weak var friLabel: UILabel!
    @IBOutlet weak var satLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(weekday),\(day),\(week)")
        updateView()
    }
    @IBAction func leftArrowButtonPressed(_ sender: Any) {
        if month == 0 {
            month = 11
            currentYear -= 1
            direction = -1
            getStartDateDayPosition()
            updateView()
        } else {
            month -= 1
            direction = -1
            getStartDateDayPosition()
            updateView()
        }
    }
    @IBAction func rightArrowPressed(_ sender: Any) {
        if month == 11 {
            month = 0
            currentYear += 1
            direction = 1
            getStartDateDayPosition()
            updateView()
        } else {
            direction = 1
            getStartDateDayPosition()
            month += 1
            updateView()
        }
    }
    
    func getStartDateDayPosition(){
        switch direction{
        case 0:
            switch day{
            case 1...7:
                numberOfEmptyBox = weekday - day
            case 8...14:
                numberOfEmptyBox = weekday - day - 7
            case 15...21:
                numberOfEmptyBox = weekday - day - 14
            case 22...28:
                numberOfEmptyBox = weekday - day - 21
            case 29...31:
                numberOfEmptyBox = weekday - day - 21
            default:
                break
            }
            positionIndex = numberOfEmptyBox
        case 1...:
            nextNumberOfEmptyBox = (positionIndex + daysInMonth[month]) % 7
            positionIndex = nextNumberOfEmptyBox
        case -1:
            previousNumberOfEmptyBox = (7 - (daysInMonth[month] - positionIndex) % 7)
            if previousNumberOfEmptyBox == 7 {
                previousNumberOfEmptyBox = 0
            }
            positionIndex = previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch direction{
        case 0:
            print("\(leapYear())")
            return leapYear() + numberOfEmptyBox
        case 1...:
            print("\(leapYear())")
            return leapYear() + nextNumberOfEmptyBox
        case -1:
            print("\(leapYear())")
            return leapYear() + previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = .clear
        
        switch direction{
        case 0:
            cell.dateLabel.text = "\(indexPath.row + 1 - numberOfEmptyBox)"
        case 1...:
            cell.dateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
        case -1:
            cell.dateLabel.text = "\(indexPath.row + 1 - previousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.dateLabel.text!)! < 1 {
            cell.isHidden = true
        } else {
            cell.isHidden = false
        }
        return cell
    }
    
    func updateView(){
        currentMonth = months[month]
        monthLabel.text = "\(currentMonth) \(currentYear)"
        calender.reloadData()
    }
    
    func leapYear() -> Int{
        if ((currentYear - 1804) % 4 == 0) && month == 1{
            return 29
        }else {
            return daysInMonth[month]
        }
    }
}
