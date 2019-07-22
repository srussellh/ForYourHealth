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
        view.backgroundColor = lightAccent
        
        symptomTextField.backgroundColor = lightShade
        symptomTextField.font = titleFont
        symptomTextField.textColor = darkShade
        symptomTextField.layer.cornerRadius = textFieldRounder
        
        cancelButton.layer.borderWidth = buttonBorder
        cancelButton.layer.borderColor = darkShade.cgColor
        cancelButton.backgroundColor = darkAccent
        cancelButton.layer.cornerRadius = cancelButton.frame.height/roundDivider
        cancelButton.setTitleColor(darkShade, for: .normal)
        cancelButton.titleLabel?.font = buttonFont
        
        createButton.layer.borderWidth = buttonBorder
        createButton.layer.borderColor = darkShade.cgColor
        createButton.backgroundColor = darkAccent
        createButton.layer.cornerRadius = cancelButton.frame.height/roundDivider
        createButton.setTitleColor(darkShade, for: .normal)
        createButton.titleLabel?.font = buttonFont
        
        if symptom != nil {
            symptomTextField.text = symptom?.detail
            update = true
            createButton.setTitle("  Update  ", for: .normal)
        } else {
            update = false
            createButton.setTitle("  Create  ", for: .normal)
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignAll))
        view.addGestureRecognizer(tapRecognizer)
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
    @objc func resignAll(){
        symptomTextField.resignFirstResponder()
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
