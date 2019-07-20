//
//  SelectionViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/18/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    var symptomIndex:Int?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var VerbalButton: UIButton!
    @IBOutlet weak var manualButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = lightShade
        titleLabel.text = "How would you like to fill out your information?"
        titleLabel.textColor = darkShade
        titleLabel.font = titleFont
        VerbalButton.layer.borderWidth = 1.0
        VerbalButton.layer.borderColor = darkShade.cgColor
        VerbalButton.layer.backgroundColor = mainBrandColor.cgColor
        VerbalButton.layer.cornerRadius = VerbalButton.frame.height/4
        VerbalButton.setTitleColor(darkShade, for: .normal)
        VerbalButton.titleLabel?.font = buttonFont
        
        manualButton.layer.borderWidth = 1.0
        manualButton.layer.borderColor = darkShade.cgColor
        manualButton.layer.backgroundColor = mainBrandColor.cgColor
        manualButton.layer.cornerRadius = manualButton.frame.height/4
        manualButton.setTitleColor(darkShade, for: .normal)
        manualButton.titleLabel?.font = buttonFont
        self.tabBarController?.tabBar.barTintColor = lightAccent
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        symptomIndex = UserController.shared.user.symptoms?.count
    }
    @IBAction func verbalButtonPressed(_ sender: Any) {
        if symptomIndex == 0 || symptomIndex == nil {
            performSegue(withIdentifier: "skipToVerbEntry", sender: nil)
        } else {
            performSegue(withIdentifier: "toVerbalSymptom", sender: nil)
        }
        
    }
    @IBAction func manualButtonPressed(_ sender: Any) {
        if symptomIndex == 0 || symptomIndex == nil {
            performSegue(withIdentifier: "skipToEntry", sender: nil)
        } else {
            performSegue(withIdentifier: "toSymptom", sender: nil)
        }
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
