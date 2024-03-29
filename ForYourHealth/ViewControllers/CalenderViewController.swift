//
//  CalenderViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var height: CGFloat?
    var width: CGFloat?
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonth = String()
    var currentYear = year
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var previousNumberOfEmptyBox = 0
    var direction = 0
    var positionIndex = 0

    @IBOutlet weak var heightConstrant: NSLayoutConstraint!
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
        getStartDateDayPosition()
        updateView()
        view.backgroundColor = lightShade
        calender.backgroundColor = lightAccent
        leftArrowButton.setTitleColor(darkAccent, for: .normal)
        rightArrowButton.setTitleColor(darkAccent, for: .normal)
        monthLabel.textColor = darkAccent
        monthLabel.font = titleFont
        sunLabel.font = dayFont
        sunLabel.textColor = darkShade
        monLabel.font = dayFont
        monLabel.textColor = darkShade
        tueLabel.font = dayFont
        tueLabel.textColor = darkShade
        wedLabel.font = dayFont
        wedLabel.textColor = darkShade
        thurLabel.font = dayFont
        thurLabel.textColor = darkShade
        friLabel.font = dayFont
        friLabel.textColor = darkShade
        satLabel.font = dayFont
        satLabel.textColor = darkShade
        width = (view.frame.width * 0.75)
        calender.layer.cornerRadius = 30
        height = (width! / 7) * 6
        heightConstrant.constant = height!
        self.view.setNeedsLayout()
        self.navigationController?.navigationBar.barTintColor = mainBrandColor
        self.tabBarController?.tabBar.barTintColor = mainBrandColor
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
    }
    @IBAction func leftArrowButtonPressed(_ sender: Any) {
        if monthIndex == 0 {
            monthIndex = 11
            currentYear -= 1
            direction = -1
            getStartDateDayPosition()
            updateView()
        } else {
            monthIndex -= 1
            direction = -1
            getStartDateDayPosition()
            updateView()
        }
    }
    @IBAction func rightArrowPressed(_ sender: Any) {
        if monthIndex == 11 {
            monthIndex = 0
            currentYear += 1
            direction = 1
            getStartDateDayPosition()
            updateView()
        } else {
            direction = 1
            getStartDateDayPosition()
            monthIndex += 1
            updateView()
        }
    }
    
    func getStartDateDayPosition(){
        switch direction{
        case 0:
            switch week{
            case 1:
                numberOfEmptyBox = weekday - day
            case 2:
                numberOfEmptyBox = 7 - (day - weekday)
            case 3:
                numberOfEmptyBox = 7 - (day - weekday - 7)
            case 4:
                numberOfEmptyBox = 7 - (day - weekday - 14)
            case 5:
                numberOfEmptyBox = 7 - (day - weekday - 21)
            case 6:
                numberOfEmptyBox = 7 - (day - weekday - 28)
            default:
                break
            }
            positionIndex = numberOfEmptyBox
        case 1...:
            nextNumberOfEmptyBox = (positionIndex + daysInMonth[monthIndex]) % 7
            positionIndex = nextNumberOfEmptyBox
        case -1:
            previousNumberOfEmptyBox = (7 - (daysInMonth[monthIndex] - positionIndex) % 7)
            if previousNumberOfEmptyBox == 7 {
                previousNumberOfEmptyBox = 0
            }
            positionIndex = previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (width! / 7), height: width! / 7)
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
        currentMonth = months[monthIndex]
        monthLabel.text = "\(currentMonth) \(currentYear)"
        calender.reloadData()
    }
    
    func leapYear() -> Int{
        if ((currentYear - 1804) % 4 == 0) && monthIndex == 1{
            return 29
        }else {
            return daysInMonth[monthIndex]
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDateDetail" {
            guard let indexPath = calender.indexPathsForSelectedItems,
                let destinationVC = segue.destination as? DateDetailViewController else {return}
            let month = monthIndex + 1
            let yearToPass = currentYear
            var day = 0
            
            switch direction{
            case 0:
                day = indexPath[0].row + 1 - numberOfEmptyBox
            case 1...:
                day = indexPath[0].row + 1 - nextNumberOfEmptyBox
            case -1:
                day = indexPath[0].row + 1 - previousNumberOfEmptyBox
            default:
                fatalError()
            }
            destinationVC.monthPassed = month
            destinationVC.year = yearToPass
            destinationVC.day = day
        }
    }
}
