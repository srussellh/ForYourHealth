//
//  ManualEntryViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/17/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class ManualEntryViewController: UIViewController {

    let user = UserController.shared.user
    
    @IBOutlet weak var entryTextField: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let entry = entryTextField.text else {return}
        EntryController.shared.createEntry(body: entry, user: user)
    }
    
}
