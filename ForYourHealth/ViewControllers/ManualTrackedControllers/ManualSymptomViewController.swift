//
//  ManualSymptomViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/17/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit

class ManualSymptomViewController: UIViewController {
    
    let user = UserController.shared.user
    let symptomIndex = UserController.shared.user.symptoms?.count
    var index = 0
    
    @IBOutlet weak var symptomLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    
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
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
            view.backgroundColor = lightShade
        updateView()
        symptomLabel.text = symptom.detail
            symptomLabel.textColor = darkShade
            symptomLabel.font = symptomFont
            skipButton.setTitleColor(darkAccent, for: .normal)
            skipButton.setTitle("Skip", for: .normal)
            skipButton.titleLabel?.font = buttonFont
            titleLabel.text = "On a scale from 0 to 10..."
            titleLabel.font = titleFont
            titleLabel.textColor = darkShade
        
    }
    
    @IBAction func zeroButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "0", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func oneButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "1", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func twoButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "2", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func threeButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "3", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func fourButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "4", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func fiveButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "5", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func sixButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "6", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func sevenButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "7", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func eightButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "8", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func nineButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "9", symptom: symptom)
        cycleOrSegue()
    }
    @IBAction func tenButtonPressed(_ sender: Any) {
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        RatingController.shared.createRating(number: "10", symptom: symptom)
        cycleOrSegue()
    }
    
    func cycleOrSegue(){
        guard let symptomIndex = symptomIndex else {return}
        index += 1
        guard  index < (symptomIndex) else { performSegue(withIdentifier: "toEntry", sender: nil); return }
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        symptomLabel.text = symptom.detail
        updateView()
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
