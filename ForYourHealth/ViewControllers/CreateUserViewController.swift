//
//  CreateUserViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/10/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createUserButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = lightAccent
        titleLabel.text = "Looks like you are new to the app. Lets start by getting your name."
        titleLabel.textColor = darkShade
        titleLabel.font = titleFont
        nameTextField.backgroundColor = lightShade
        nameTextField.font = titleFont
        nameTextField.textColor = darkShade
        createUserButton.layer.borderWidth = 1.0
        createUserButton.layer.borderColor = darkShade.cgColor
        createUserButton.layer.backgroundColor = mainBrandColor.cgColor
        createUserButton.layer.cornerRadius = createUserButton.frame.height/4
        createUserButton.setTitleColor(darkShade, for: .normal)
        createUserButton.titleLabel?.font = buttonFont
    }
    @IBAction func createUserButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {return}
        UserController.shared.createUser(name: name)
        performSegue(withIdentifier: "fromCreatetoTabBar", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
