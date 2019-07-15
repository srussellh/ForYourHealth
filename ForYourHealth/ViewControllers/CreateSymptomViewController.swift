//
//  CreateSymptomViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/10/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class CreateSymptomViewController: UIViewController {

    let user = UserController.shared.user
    
    @IBOutlet weak var symptomTextField: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        
        SymptomController.shared.createSymptom(detail: symptomTextField.text, user: user)
        navigationController?.popViewController(animated: true)
    }
    
    

}
