//
//  EditFoodEntryViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/19/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class EditFoodEntryViewController: UIViewController {
    
    let user = UserController.shared.user
    var foodEntry = FoodEntry()
    @IBOutlet weak var foodEntryTextField: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodEntryTextField.backgroundColor = lightShade
        foodEntryTextField.layer.cornerRadius = textFieldRounder
        foodEntryTextField.textColor = darkShade
        foodEntryTextField.font = titleFont
        foodEntryTextField.text = foodEntry.details
        view.backgroundColor = lightAccent
        
        doneButton.setTitleColor(darkAccent, for: .normal)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = buttonFont
        titleLabel.text = "What did you eat today?"
        titleLabel.font = titleFont
        titleLabel.textColor = darkShade
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignAll))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let detail = foodEntryTextField.text else {return}
        FoodEntryController.shared.updateFoodEntry(foodEntry: foodEntry, detail: detail)
        navigationController?.popViewController(animated: true)
    }
    @objc func resignAll(){
        foodEntryTextField.resignFirstResponder()
    }

}
