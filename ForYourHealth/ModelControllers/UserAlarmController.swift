//
//  UserAlarmController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation
import UserNotifications

class UserAlarmController {
    static let shared = UserAlarmController()
    
    func createAlarm(user: User, name:String, hour:Int, minute:Int, amOrPm: Int, weekdays: [Int]){
        
        let alarm = Alarm(withUser: user, name: name, hour: hour, minute: minute, amOrPm: amOrPm, weekdays: weekdays)
        for weekday in weekdays{
            scheduleUserNotifications(for: alarm, weekday: weekday)
            UserController.shared.saveToPersistentStore()
        }
    }
    
    func toggleSwitch(alarm: Alarm){
        alarm.enabled = !alarm.enabled
        if alarm.enabled == true {
            for weekday in alarm.weekdays {
                scheduleUserNotifications(for: alarm, weekday: Int(weekday))
            }
        }else{
                cancelUserNotifications(for: alarm)
        }
        UserController.shared.saveToPersistentStore()
    }
    
//    func updateAlarm(alarm: Alarm, name: String, fireDate:Date, enabled: Bool){
//        alarm.name = name
//        alarm.enabled = enabled
//        alarm.fireDate = fireDate
//        UserController.shared.saveToPersistentStore()
//    }
    
    func deleteAlarm(alarm: Alarm){
        let moc = CoreDataStack.context
        moc.delete(alarm)
        UserController.shared.saveToPersistentStore()
    }
}

extension UserAlarmController{
    func scheduleUserNotifications(for alarm: Alarm, weekday:Int){
        let content = UNMutableNotificationContent()
        content.title = alarm.name ?? "Alert"
        content.sound = .default
        
        
        var date = DateComponents()
        date.weekday = weekday
        date.hour = Int(alarm.hour)
        date.minute = Int(alarm.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid!, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("unable to schedule local notification request: \(error) : \(error.localizedDescription)")
            }
            print("\(date.weekday), \(date.hour), \(date.minute)")
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid!])
    }
}
