//
//  EntryController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation

class EntryController{
    static let shared = EntryController()
    
    func createEntry(body:String, user:User){
        Entry(body: body, user: user)
        UserController.shared.saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, body:String){
        entry.body = body
        UserController.shared.saveToPersistentStore()
    }
    
    func deleteEntry(entry: Entry){
        let moc = CoreDataStack.context
        moc.delete(entry)
        UserController.shared.saveToPersistentStore()
    }
}
