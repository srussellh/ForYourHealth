//
//  EditRatingViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/19/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class EditRatingViewController: UIViewController {

    let user = UserController.shared.user
    var rating = Rating()
    @IBOutlet weak var symptomLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    
    override func viewDidLoad() {
       
            super.viewDidLoad()
            view.backgroundColor = lightShade
            updateView()
            symptomLabel.text = rating.symptom?.detail
            symptomLabel.textColor = darkShade
            symptomLabel.font = symptomFont
        
            titleLabel.text = "On a scale from 1 to 10..."
            titleLabel.font = titleFont
            titleLabel.textColor = darkShade
        
    }
    
    @IBAction func zeroButtonPressed(_ sender: Any) {
        RatingController.shared.updateRating(rating: rating, number: "0")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func oneButtonPressed(_ sender: Any) {
       RatingController.shared.updateRating(rating: rating, number: "1")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func twoButtonPressed(_ sender: Any) {
        RatingController.shared.updateRating(rating: rating, number: "2")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func threeButtonPressed(_ sender: Any) {
        RatingController.shared.updateRating(rating: rating, number: "3")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func fourButtonPressed(_ sender: Any) {
        RatingController.shared.updateRating(rating: rating, number: "4")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func fiveButtonPressed(_ sender: Any) {
       RatingController.shared.updateRating(rating: rating, number: "5")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func sixButtonPressed(_ sender: Any) {
       RatingController.shared.updateRating(rating: rating, number: "6")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func sevenButtonPressed(_ sender: Any) {
        RatingController.shared.updateRating(rating: rating, number: "7")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func eightButtonPressed(_ sender: Any) {
        RatingController.shared.updateRating(rating: rating, number: "8")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func nineButtonPressed(_ sender: Any) {
        RatingController.shared.updateRating(rating: rating, number: "9")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tenButtonPressed(_ sender: Any) {
        RatingController.shared.updateRating(rating: rating, number: "10")
        navigationController?.popViewController(animated: true)
    }
    
    
    func updateView(){
        zeroButton.setTitleColor(darkAccent, for: .normal)
        oneButton.setTitleColor(darkAccent, for: .normal)
        twoButton.setTitleColor(darkAccent, for: .normal)
        threeButton.setTitleColor(darkAccent, for: .normal)
        fourButton.setTitleColor(darkAccent, for: .normal)
        fiveButton.setTitleColor(darkAccent, for: .normal)
        sixButton.setTitleColor(darkAccent, for: .normal)
        sevenButton.setTitleColor(darkAccent, for: .normal)
        eightButton.setTitleColor(darkAccent, for: .normal)
        nineButton.setTitleColor(darkAccent, for: .normal)
        tenButton.setTitleColor(darkAccent, for: .normal)
        zeroButton.backgroundColor = lightAccent
        oneButton.backgroundColor = lightAccent
        twoButton.backgroundColor = lightAccent
        threeButton.backgroundColor = lightAccent
        fourButton.backgroundColor = lightAccent
        fiveButton.backgroundColor = lightAccent
        sixButton.backgroundColor = lightAccent
        sevenButton.backgroundColor = lightAccent
        eightButton.backgroundColor = lightAccent
        nineButton.backgroundColor = lightAccent
        tenButton.backgroundColor = lightAccent
        zeroButton.layer.cornerRadius = zeroButton.frame.height/roundDivider
        oneButton.layer.cornerRadius = oneButton.frame.height/roundDivider
        twoButton.layer.cornerRadius = twoButton.frame.height/roundDivider
        threeButton.layer.cornerRadius = threeButton.frame.height/roundDivider
        fourButton.layer.cornerRadius = fourButton.frame.height/roundDivider
        fiveButton.layer.cornerRadius = fiveButton.frame.height/roundDivider
        sixButton.layer.cornerRadius = sixButton.frame.height/roundDivider
        sevenButton.layer.cornerRadius = sevenButton.frame.height/roundDivider
        eightButton.layer.cornerRadius = eightButton.frame.height/roundDivider
        nineButton.layer.cornerRadius = nineButton.frame.height/roundDivider
        tenButton.layer.cornerRadius = tenButton.frame.height/roundDivider
        zeroButton.titleLabel?.font = numberFont
        oneButton.titleLabel?.font = numberFont
        twoButton.titleLabel?.font = numberFont
        threeButton.titleLabel?.font = numberFont
        fourButton.titleLabel?.font = numberFont
        fiveButton.titleLabel?.font = numberFont
        sixButton.titleLabel?.font = numberFont
        sevenButton.titleLabel?.font = numberFont
        eightButton.titleLabel?.font = numberFont
        nineButton.titleLabel?.font = numberFont
        tenButton.titleLabel?.font = numberFont
    }
}
