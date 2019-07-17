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
        
        symptomLabel.text = symptom.detail
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
        guard  index < (symptomIndex) else { performSegue(withIdentifier: "toManFoodEntry", sender: nil); return }
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        symptomLabel.text = symptom.detail
    }
}
