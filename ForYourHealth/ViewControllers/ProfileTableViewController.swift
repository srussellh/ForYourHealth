//
//  ProfileTableViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/10/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    var initialSession = UIView()
    var initialLabel = UILabel()
    
    let user = UserController.shared.user
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewHeight = (navigationController?.navigationBar.frame.height)!
        initialSession = UIView(frame: CGRect(x: 0, y: viewHeight + 30, width: self.view.frame.width, height: self.view.frame.height))
        initialSession.addSubview(initialLabel)
        initialLabel = UILabel(frame: CGRect(x: view.frame.width/2, y: 20, width: view.frame.width/2, height: view.frame.height))
        initialSession.backgroundColor = lightGray
        initialSession.addSubview(initialLabel)
        self.navigationController?.view.addSubview(initialSession)
        initialSession.bringSubviewToFront(initialLabel)
        initialLabel.text = "Click on the '+' to add a symptom or a reminder to enter an alert to fill out your entries."
        initialLabel.font = titleFont
        initialLabel.textColor = .black
        initialLabel.numberOfLines = 4
        initialLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.nameLabel.text = user.name
        nameLabel.textColor = darkShade
        nameLabel.font = headerFont
        addButton.tintColor = darkAccent
        tableView.backgroundColor = lightShade
        labelView.backgroundColor = lightShade
        self.navigationController?.navigationBar.barTintColor = mainBrandColor
        self.tabBarController?.tabBar.barTintColor = mainBrandColor
        
        var backButtonBackgroundImage = UIImage(named: "BackButton")
        
        backButtonBackgroundImage =
            backButtonBackgroundImage!.resizableImage(withCapInsets:
                UIEdgeInsets(top: 0, left: backButtonBackgroundImage!.size.width - 1, bottom: 0, right: 0))
        
        let barAppearance =
            UINavigationBar.appearance(whenContainedInInstancesOf: [ProfileTableViewController.self])
        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        
        // Provide an empty backBarButton to hide the 'Back' text present by default in the back button.
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if user.ifYouKnow == false {
            initialSession.isHidden = false
        } else {
            initialSession.isHidden = true
        }
        tableView.reloadData()
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        alertUser(withMessage: "What would you like to add?")
        UserController.shared.updateUser(user: user, ifYouKnow: true)
        initialSession.isHidden = true
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
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = UILabel()
            header.font = titleFont
            header.textColor = darkShade
            header.text = "      Symptoms"
            header.backgroundColor = lightAccent
            
            return header
        } else {
            let header = UILabel()
            header.font = titleFont
            header.textColor = darkShade
            header.text = "      Alert"
            header.backgroundColor = lightAccent
            
            return header
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        if indexPath.section == 0{
            guard let symptom = user.symptoms?.object(at: indexPath.row) as? Symptom
                else {return UITableViewCell()}
            cell.backgroundColor = lightShade
            cell.textLabel?.font = titleFont
            cell.textLabel?.textColor = darkShade
            cell.textLabel?.text = symptom.detail
            return cell
        } else {
            guard let alarm = user.alarm?.object(at: indexPath.row) as? Alarm else {return UITableViewCell()}
            cell.backgroundColor = lightShade
            cell.textLabel?.font = titleFont
            cell.textLabel?.textColor = darkShade
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
