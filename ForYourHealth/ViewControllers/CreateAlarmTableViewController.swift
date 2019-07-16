//
//  CreateAlarmTableViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class CreateAlarmTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let user = UserController.shared.user
    var weekdays: [Int] = []
    var pickerData: [[String]] = [[String]]()
    var hour = Int()
    var minute = Int()
    var amOrPm = Int()
    
    
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
    }

    @IBAction func sundayButtonTapped(_ sender: Any) {
        if weekdays.contains(1) {
            let index = weekdays.firstIndex(of: 1)
            weekdays.remove(at: index!)
        } else {
            weekdays.append(1)
        }
    }
    @IBAction func mondayButtonTapped(_ sender: Any) {
        if weekdays.contains(2) {
            let index = weekdays.firstIndex(of: 2)
            weekdays.remove(at: index!)
        } else {
            weekdays.append(2)
        }
    }
    @IBAction func tuesdayButtonTapped(_ sender: Any) {
        if weekdays.contains(3) {
            let index = weekdays.firstIndex(of: 3)
            weekdays.remove(at: index!)
        } else {
            weekdays.append(3)
        }
    }
    @IBAction func wednesdayButtonTapped(_ sender: Any) {
        if weekdays.contains(4) {
            let index = weekdays.firstIndex(of: 4)
            weekdays.remove(at: index!)
        } else {
            weekdays.append(4)
        }
    }
    @IBAction func thursdayButtonTapped(_ sender: Any) {
        if weekdays.contains(5) {
            let index = weekdays.firstIndex(of: 5)
            weekdays.remove(at: index!)
        } else {
            weekdays.append(5)
        }
    }
    @IBAction func fridayButtonTapped(_ sender: Any) {
        if weekdays.contains(6) {
            let index = weekdays.firstIndex(of: 6)
            weekdays.remove(at: index!)
        } else {
            weekdays.append(6)
        }
    }
    @IBAction func saturdayButtonTapped(_ sender: Any) {
        if weekdays.contains(7) {
            let index = weekdays.firstIndex(of: 7)
            weekdays.remove(at: index!)
        } else {
            weekdays.append(7)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = alertTitle.text else {return}
//        let date = datePicker.date
//        UserAlarmController.shared.createAlarm(user: UserController.shared.user, name: name, fireDate: date, weekdays: weekdays)
        if amOrPm == 1 && hour == 12 {
            hour = 0
        }else if amOrPm == 1 {
            hour = hour + 13
        } else {
            hour = hour + 1
        }
        UserAlarmController.shared.createAlarm(user: user, name: name, hour: hour, minute: minute, amOrPm: amOrPm, weekdays: weekdays)
        navigationController?.popViewController(animated: true)
        
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
        print("hour\(hour),minute\(minute),amOrPM\(amOrPm)")
    }
    
    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
