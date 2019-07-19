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
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryTextField.backgroundColor = lightShade
        entryTextField.layer.cornerRadius = textFieldRounder
        entryTextField.textColor = darkShade
        entryTextField.font = titleFont
        entryTextField.text = ""
        view.backgroundColor = lightAccent
        skipButton.setTitleColor(darkAccent, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = buttonFont
        nextButton.setTitleColor(darkAccent, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = buttonFont
        titleLabel.text = "Journal Entry"
        titleLabel.font = titleFont
        titleLabel.textColor = darkShade
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignAll))
        view.addGestureRecognizer(tapRecognizer)
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let entry = entryTextField.text else {return}
        EntryController.shared.createEntry(body: entry, user: user)
    }
    
    @objc func resignAll(){
        entryTextField.resignFirstResponder()
    }
}


