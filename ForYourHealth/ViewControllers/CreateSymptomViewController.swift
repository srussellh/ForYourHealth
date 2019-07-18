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
    var symptom: Symptom?
    var update: Bool?
    
    @IBOutlet weak var symptomTextField: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if symptom != nil {
            symptomTextField.text = symptom?.detail
            update = true
            createButton.setTitle("Update", for: .normal)
        } else {
            update = false
            createButton.setTitle("Create", for: .normal)
        }
        
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        if symptomTextField.text == "" {
            alertUser(withMessage: "Please describe your symptom")
        } else {
            if update == false {
                SymptomController.shared.createSymptom(detail: symptomTextField.text, user: user)
            } else {
                SymptomController.shared.updateSymptom(symptom: symptom!, detail: symptomTextField.text)
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
extension CreateSymptomViewController {
    func alertUser(withMessage message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}
