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
        updateView()
    }
    @IBAction func leftArrowButtonPressed(_ sender: Any) {
        if month == 0 {
            month = 11
            currentYear -= 1
            updateView()
        } else {
            month -= 1
            updateView()
        }
    }
    @IBAction func rightArrowPressed(_ sender: Any) {
        if month == 11 {
            month = 0
            currentYear += 1
            updateView()
        } else {
            month += 1
            updateView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if ((currentYear - 1804) % 4 == 0) && month == 1{
            print("🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿")
            return 29
        }else {
        return daysInMonth[month]
        }
//        print("\(daysInMonth[month])")
//        return daysInMonth[month]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = .clear
        cell.dateLabel.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func updateView(){
        currentMonth = months[month]
        monthLabel.text = "\(currentMonth) \(currentYear)"
        calender.reloadData()
    }
}
