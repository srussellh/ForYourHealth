//
//  EditEntryViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/19/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class EditEntryViewController: UIViewController {
    let user = UserController.shared.user
    var entry = Entry()
    
    @IBOutlet weak var entryTextField: UITextView!
    @IBOutlet weak var nextButton: UIButton!
   
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryTextField.backgroundColor = lightShade
        entryTextField.layer.cornerRadius = textFieldRounder
        entryTextField.textColor = darkShade
        entryTextField.font = titleFont
        entryTextField.text = entry.body
        view.backgroundColor = lightAccent
        nextButton.setTitleColor(darkAccent, for: .normal)
        nextButton.setTitle("Done", for: .normal)
        nextButton.titleLabel?.font = buttonFont
        titleLabel.text = "Journal Entry"
        titleLabel.font = titleFont
        titleLabel.textColor = darkShade
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignAll))
        view.addGestureRecognizer(tapRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let entryBody = entryTextField.text else {return}
        EntryController.shared.updateEntry(entry: entry, body: entryBody)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func resignAll(){
        entryTextField.resignFirstResponder()
    }
    @objc func keyboardWillChange(notification: Notification){
        let keyBoardsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if notification.name == UIResponder.keyboardWillChangeFrameNotification || notification.name == UIResponder.keyboardWillShowNotification{
            entryTextField.contentInset = UIEdgeInsets(
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
