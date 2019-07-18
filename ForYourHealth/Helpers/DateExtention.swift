//
//  DateExtention.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation

extension Date {
    
    /**
     Sets the `Date` to 12pm noon.
     * Use `.isSameDay(as:)` when comparing days.
     */
    func atNoon() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var date = self
        if let noon = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self) { date = noon }
        return date
    }
    
    /** Returns the `Date` as a `String` formatted to mm/dd/yy. */
    var mmddyy: String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    /** Returns the `Date` as a `String` formatted to mm/dd. */
    var mmdd: String {
        
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return "\(month)/\(day)"
    }
    
    /**
     Returns the `Date` as a `String`. Spells out month. Leaves day as an integer.
     * Example: "March 9"
     */
    var monthDay: String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        return formatter.string(from: self)
    }
    
    /** Returns `true` if both `Date`s share the same `.day` and `.month` component.
     * Does *not* compare `.year`.
     - parameter date: The `Date` being compared.*/
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.day = calendar.component(.day, from: self)
        components.month = calendar.component(.month, from: self)
        
        return calendar.date(date, matchesComponents: components)
    }
}
