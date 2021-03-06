//
//  HourlyForecast.swift
//  weatherAppExampleTwo
//
//  Created by Paige Walters on 2/11/16.
//  Copyright © 2016 Paige Walters. All rights reserved.
//

import Foundation

struct HourlyForecast {
    
    let tempC: String
    let tempF: String
    var hourlyCondtion: String
    let hourlyHour: String
    let hourlyDate: String
    let hourlyTime: String
    let hourlyDay: String
    let hourlyIcon: String
    var hourlyHigh: Bool = false
    var hourlyLow: Bool = false
    var firstOccurence: Bool = false

    
    init(tempC: String, tempF: String, hourlyCondition: String, hourlyHour: String, hourlyDate: String, hourlyTime: String, hourlyDay: String, hourlyIcon: String, hourlyHigh: Bool, hourlyLow: Bool, firstOccurence: Bool) {
    
    self.tempC = tempC
    self.tempF = tempF
    self.hourlyCondtion = hourlyCondition
    self.hourlyHour = hourlyHour
    self.hourlyDate = hourlyDate
    self.hourlyTime = hourlyTime
    self.hourlyDay = hourlyDay
    self.hourlyIcon = hourlyIcon
    self.hourlyHigh = hourlyHigh
    self.hourlyLow = hourlyLow
    self.firstOccurence = firstOccurence
        
    }
}

