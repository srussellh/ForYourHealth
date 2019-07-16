//
//  MedicationController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

class MedicationController{
    static let shared = MedicationController()
    
    
    
    
    @discardableResult func createMedication(name:String, user:User) -> MedIcation{
        let med = MedIcation(name: name, user: user)
        UserController.shared.saveToPersistentStore()
        return med
    }
    func updateMedication(medication: MedIcation, name: String){
        medication.name = name
        UserController.shared.saveToPersistentStore()
    }
    
    func deleteMedication(medication:MedIcation){
        let moc = CoreDataStack.context
        moc.delete(medication)
        UserController.shared.saveToPersistentStore()
    }
}
