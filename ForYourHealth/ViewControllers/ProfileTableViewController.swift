//
//  ProfileTableViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/10/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    let user = UserController.shared.user
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = user.name
        self.tabBarController?.tabBar.barTintColor = lightAccent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        alertUser(withMessage: "What would you like to add?")
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            guard let symptoms = user.symptoms else {return 0}
            return symptoms.count
        } else {
            guard let alarms = user.alarm else {return 0}
            return alarms.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Symptoms"
        } else {
            return "Alerts"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        if indexPath.section == 0{
            guard let symptom = user.symptoms?.object(at: indexPath.row) as? Symptom
                else {return UITableViewCell()}
            cell.textLabel?.text = symptom.detail
            return cell
        } else {
            guard let alarm = user.alarm?.object(at: indexPath.row) as? Alarm else {return UITableViewCell()}
            cell.textLabel?.text = alarm.name
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            performSegue(withIdentifier: "toExistingSymptom", sender: nil)
        }else {
            performSegue(withIdentifier: "toExistingAlarm", sender: nil)
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                guard let symptom = user.symptoms?.object(at: indexPath.row) as? Symptom
                    else {return}
                SymptomController.shared.deleteSymptom(symptom: symptom)
            } else {
                guard let alarm = user.alarm?.object(at: indexPath.row) as? Alarm else {return}
                UserAlarmController.shared.deleteAlarm(alarm: alarm)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toExistingSymptom" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let symptom = user.symptoms?.object(at: indexPath.row) as? Symptom,
                let destinationVC = segue.destination as? CreateSymptomViewController else {return}
            destinationVC.symptom = symptom
        } else if segue.identifier == "toExistingAlarm"{
            guard let indexPath = tableView.indexPathForSelectedRow,
                let alarm = user.alarm?.object(at: indexPath.row) as? Alarm,
                let desinationVC = segue.destination as? CreateAlarmTableViewController else {return}
            desinationVC.alarm = alarm
        }
    }
}

extension ProfileTableViewController {
    func alertUser(withMessage message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let createAlarm = UIAlertAction(title: "Add an Alert", style: .default) { (_) in
            self.performSegue(withIdentifier: "toCreateAlert", sender: nil)
        }
        let createSymptom = UIAlertAction(title: "Add a Symptom", style: .default) { (_) in
            self.performSegue(withIdentifier: "toCreateSymptom", sender: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createAlarm)
        alertController.addAction(createSymptom)
        self.present(alertController, animated: true)
    }
}
