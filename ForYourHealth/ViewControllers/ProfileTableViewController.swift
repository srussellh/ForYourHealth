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
        // #warning Incomplete implementation, return the number of sections
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
            
            cell.textLabel?.text = String(describing: alarm.name)
            return cell
        }
    }
    
    
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
