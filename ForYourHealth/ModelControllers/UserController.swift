//
//  UserController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/10/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import CoreData

class UserController{
    static let shared = UserController()
    
    var name: [User]{
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let result = (try? moc.fetch(fetchRequest))
        return result ?? []
    }
    
    var user: User{
        return name[0]
    }
    
    func updateUser(user: User, ifYouKnow: Bool){
        user.ifYouKnow = true
        saveToPersistentStore()
    }
    
    //MARK: -Crud functions
    func createUser(name:String){
        User(name: name)
        saveToPersistentStore()
    }
    
    //create an update function?
    
    func saveToPersistentStore()  {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("There was an error saving this data: \(error.localizedDescription)")
        }
    }
    
}
