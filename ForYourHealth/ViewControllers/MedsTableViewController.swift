//
//  MedsTableViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/16/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class MedsTableViewController: UITableViewController {
    
    let user = UserController.shared.user
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let medication = user.medication else {return 0}
        // #warning Incomplete implementation, return the number of rows
        return medication.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medCells", for: indexPath)
        guard let medication = user.medication?.object(at: indexPath.row) as? MedIcation else {return UITableViewCell()}
        cell.textLabel?.text = medication.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let medication = user.medication?.object(at: indexPath.row) as? MedIcation else {return}
            MedicationController.shared.deleteMedication(medication: medication)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

