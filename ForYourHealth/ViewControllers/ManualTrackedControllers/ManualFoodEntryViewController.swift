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
    var symptomIndex:Int?
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        symptomIndex = UserController.shared.user.symptoms?.count
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        if symptomIndex == 0 {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let detail = foodEntryTextField.text else {return}
        FoodEntryController.shared.createFoodEntry(detail: detail, user: user)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @objc func resignAll(){
        foodEntryTextField.resignFirstResponder()
    }
    @objc func keyboardWillChange(notification: Notification){
        let keyBoardsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if notification.name == UIResponder.keyboardWillChangeFrameNotification || notification.name == UIResponder.keyboardWillShowNotification{
            foodEntryTextField.contentInset = UIEdgeInsets(
                top: 0.0,
                left: 0.0,
                bottom: keyBoardsize.height,
                right: 0.0
            )
            view.layoutIfNeeded()
        } else {
            view.frame.origin.y = 0
        }
    }
}
