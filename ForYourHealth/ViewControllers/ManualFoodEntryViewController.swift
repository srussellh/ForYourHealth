//
//  ManualFoodEntryViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/17/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class ManualFoodEntryViewController: UIViewController {
    @IBOutlet weak var foodEntryTextField: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
