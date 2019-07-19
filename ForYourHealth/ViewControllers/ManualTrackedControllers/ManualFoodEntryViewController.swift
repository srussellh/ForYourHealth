//
//  ManualFoodEntryViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/17/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class ManualFoodEntryViewController: UIViewController {
    
    let user = UserController.shared.user
    
    @IBOutlet weak var foodEntryTextField: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodEntryTextField.backgroundColor = lightShade
        foodEntryTextField.layer.cornerRadius = textFieldRounder
        foodEntryTextField.textColor = darkShade
        foodEntryTextField.font = titleFont
        foodEntryTextField.text = ""
        view.backgroundColor = lightAccent
        skipButton.setTitleColor(darkAccent, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = buttonFont
        doneButton.setTitleColor(darkAccent, for: .normal)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = buttonFont
        titleLabel.text = "What did you eat today?"
        titleLabel.font = titleFont
        titleLabel.textColor = darkShade

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignAll))
        view.addGestureRecognizer(tapRecognizer)
    }
    @IBAction func skipButtonPressed(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let detail = foodEntryTextField.text else {return}
        FoodEntryController.shared.createFoodEntry(detail: detail, user: user)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @objc func resignAll(){
        foodEntryTextField.resignFirstResponder()
    }
}
