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
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let entryBody = entryTextField.text else {return}
        EntryController.shared.updateEntry(entry: entry, body: entryBody)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func resignAll(){
        entryTextField.resignFirstResponder()
    }
}
