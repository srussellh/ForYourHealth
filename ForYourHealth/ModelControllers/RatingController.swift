//
//  RatingController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/10/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation

class RatingController{
    static let shared = RatingController()
    
    func createRating(number: String, symptom: Symptom){
        Rating(number: number, symptom: symptom)
        UserController.shared.saveToPersistentStore()
    }
    
    func updateRating(rating: Rating, number: String){
        rating.number = number
        UserController.shared.saveToPersistentStore()
    }
}
