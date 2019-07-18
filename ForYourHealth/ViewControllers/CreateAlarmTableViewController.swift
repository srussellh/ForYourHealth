//
//  CreateAlarmTableViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class CreateAlarmTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var alarm: Alarm?
    let user = UserController.shared.user
    var weekdays: [Int] = []
    var pickerData: [[String]] = [[String]]()
    var hour = 1
    var minute = 0
    var amOrPm = 0
    
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var alertTitle: UITextField!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var disableAlertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = [["1","2","3","4","5","6","7","8","9","10","11","12"], ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"],["AM","PM"]]
        if alarm != nil {
            alertTitle.text = alarm?.name
            weekdays = (alarm?.weekdays.map{ Int($0) }) ?? []
            if weekdays.contains(1){sundayButton.backgroundColor = .green}
            if weekdays.contains(2){mondayButton.backgroundColor = .green}
            if weekdays.contains(3){tuesdayButton.backgroundColor = .green}
            if weekdays.contains(4){wednesdayButton.backgroundColor = .green}
            if weekdays.contains(5){thursdayButton.backgroundColor = .green}
            if weekdays.contains(6){fridayButton.backgroundColor = .green}
            if weekdays.contains(7){saturdayButton.backgroundColor = .green}
            hour = Int(alarm!.hour)
            minute = Int(alarm!.minute)
            amOrPm = Int(alarm!.amOrPm)
            if hour == 0{
                hour = 11
                self.picker.selectRow(hour, inComponent: 0, animated: true)
            } else if amOrPm == 0 {
                hour -= 1
                self.picker.selectRow(hour, inComponent: 0, animated: true)
            } else if amOrPm == 1 {
                hour -= 13
                self.picker.selectRow(hour, inComponent: 0, animated: true)
            }
            self.picker.selectRow(minute, inComponent: 1, animated: true)
            self.picker.selectRow(amOrPm, inComponent: 2, animated: true)
            
        }
        
    }

    @IBAction func sundayButtonTapped(_ sender: Any) {
        if weekdays.contains(1) {
            let index = weekdays.firstIndex(of: 1)
            weekdays.remove(at: index!)
            sundayButton.backgroundColor = .white
        } else {
            weekdays.append(1)
            sundayButton.backgroundColor = .green
        }
    }
    @IBAction func mondayButtonTapped(_ sender: Any) {
        if weekdays.contains(2) {
            let index = weekdays.firstIndex(of: 2)
            weekdays.remove(at: index!)
            mondayButton.backgroundColor = .white
        } else {
            weekdays.append(2)
            mondayButton.backgroundColor = .green
        }
    }
    @IBAction func tuesdayButtonTapped(_ sender: Any) {
        if weekdays.contains(3) {
            let index = weekdays.firstIndex(of: 3)
            weekdays.remove(at: index!)
            tuesdayButton.backgroundColor = .white
        } else {
            weekdays.append(3)
            tuesdayButton.backgroundColor = .green
        }
    }
    @IBAction func wednesdayButtonTapped(_ sender: Any) {
        if weekdays.contains(4) {
            let index = weekdays.firstIndex(of: 4)
            weekdays.remove(at: index!)
            wednesdayButton.backgroundColor = .white
        } else {
            weekdays.append(4)
            wednesdayButton.backgroundColor = .green
        }
    }
    @IBAction func thursdayButtonTapped(_ sender: Any) {
        if weekdays.contains(5) {
            let index = weekdays.firstIndex(of: 5)
            weekdays.remove(at: index!)
            thursdayButton.backgroundColor = .white
        } else {
            weekdays.append(5)
            thursdayButton.backgroundColor = .green
        }
    }
    @IBAction func fridayButtonTapped(_ sender: Any) {
        if weekdays.contains(6) {
            let index = weekdays.firstIndex(of: 6)
            weekdays.remove(at: index!)
            fridayButton.backgroundColor = .white
        } else {
            weekdays.append(6)
            fridayButton.backgroundColor = .green
        }
    }
    @IBAction func saturdayButtonTapped(_ sender: Any) {
        if weekdays.contains(7) {
            let index = weekdays.firstIndex(of: 7)
            weekdays.remove(at: index!)
            saturdayButton.backgroundColor = .white
        } else {
            weekdays.append(7)
            saturdayButton.backgroundColor = .green
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = alertTitle.text else {return}
        if amOrPm == 0 && hour == 12 {
            hour = 0
        }else if amOrPm == 1 {
            hour = hour + 13
        } else {
            hour = hour + 1
        }
        
        if name == "" {
            alertUser(withMessage: "Please provide a title for this Alert.")
        } else if weekdays == [] {
            alertUser(withMessage: "Please select which days you would like the Alert to sound.")
        } else {
            if alarm == nil {
                
        UserAlarmController.shared.createAlarm(user: user, name: name, hour: hour, minute: minute, amOrPm: amOrPm, weekdays: weekdays)
            } else {
                UserAlarmController.shared.updateAlarm(alarm: alarm!, name: name, hour: hour, minute: minute, amOrPm: amOrPm, weekdays: weekdays)
            }
            navigationController?.popViewController(animated: true)
        }
        print("hour\(hour),minute\(minute),amOrPM\(amOrPm)")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
        return 12
        }else if component == 1 {
            return 60
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            hour = row
        } else if component == 1 {
            minute = row
        } else if component == 2 {
            amOrPm = row
        }
    }
}
extension CreateAlarmTableViewController {
    func alertUser(withMessage message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}
