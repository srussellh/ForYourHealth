//
//  SymptomController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/10/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation

class SymptomController {
    static let shared = SymptomController()
    
    func createSymptom(detail: String, user: User){
        Symptom(detail: detail, user: user)
        UserController.shared.saveToPersistentStore()
    }
    func deleteSymptom(symptom: Symptom){
        let moc = CoreDataStack.context
        moc.delete(symptom)
        UserController.shared.saveToPersistentStore()
    }
}
