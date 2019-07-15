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
    
    func createRating(rating: String, symptom: Symptom){
        Rating(number: rating, symptom: symptom)
        UserController.shared.saveToPersistentStore()

    }
    
}
