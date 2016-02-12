//
//  CurrentWeather.swift
//  weatherAppExampleTwo
//
//  Created by Paige Walters on 2/11/16.
//  Copyright © 2016 Paige Walters. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let currentCityName: String
    let currentTemp: Double
    let currentCondition: String
    
    init(currentCityName: String, currentTemp: Double, currentCondition: String){
        self.currentCityName = currentCityName
        self.currentTemp = currentTemp
        self.currentCondition = currentCondition
        
    }
}