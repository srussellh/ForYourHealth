//
//  CalenderVariables.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/15/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import Foundation

let date = Date()
let calender = Calendar.current

var day = calender.component(.day, from: date)
var weekday = calender.component(.weekday, from: date)
var week = calender.component(.weekOfMonth, from: date)
var monthIndex = calender.component(.month, from: date) - 1
var year = calender.component(.year, from: date)




