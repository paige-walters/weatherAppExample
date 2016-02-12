//
//  WeatherService.swift
//  weatherAppExampleTwo
//
//  Created by Paige Walters on 2/11/16.
//  Copyright © 2016 Paige Walters. All rights reserved.
//

import Foundation
import Alamofire

// class for making a call to get the current weather and forecast from wunderground api

protocol WeatherServiceDelegate {
    func setWeather(currentWeather: CurrentWeather)
    func displayForecast(hourlyData: HourlyForecast)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?

    // API key that needs to be secured (need to look into how)
    let myAPI = "d5d791369c744a64"
    
    // Array for all hourly info that is structured now
    var hourlyData = Array<HourlyForecast>()
    
    
    func getWeatherForZip(zip: String){
      
        // get request for weather data
        
        let query = zip
        
        let postEndpoint: String = "http://api.wunderground.com/api/\(myAPI)/conditions/hourly10day/q/\(query).json"
        Alamofire.request(.GET, postEndpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON
                    let post = JSON(value)
                    // now we have the results, let's just print them
//                    print("The post is: " + post.description)
                    
                    // grabbing the current weather and bundling it all up
                    if let currentTemp = post["current_observation"]["temp_f"].double,
                        let currentCondition = post["current_observation"]["weather"].string,
                        let currentCityName = post["current_observation"]["display_location"]["city"].string {
                            
                        let currentWeather = CurrentWeather(currentCityName: currentCityName, currentTemp: currentTemp, currentCondition: currentCondition)
//                            print(currentWeather)
                       
                            
                                
                    // pulling out the 10 day forecast
                            let hourlyForecastResponse = post["hourly_forecast"].arrayObject!
                            
                            for hour in hourlyForecastResponse {
                                
                                let tempC = hour["temp"]!!["metric"]! as! String
                                let tempF = hour["temp"]!!["english"]! as! String
                                let hourlyCondition = hour["condition"]! as! String
                                let hourlyDate = hour["FCTTIME"]!!["pretty"]! as! String
                                let hourlyHour = hour["FCTTIME"]!!["hour"]! as! String
                                let hourlyTime = hour["FCTTIME"]!!["civil"]! as! String
                                let hourlyDay = hour["FCTTIME"]!!["weekday_name"]! as! String
                                let hourlyIcon = hour["icon_url"]! as! String
                                
//                            print("This is \(tempC!) \(tempF!) \(hourlyCondition!) \(hourlyDate!) \(hourlyHour!) \(hourlyTime!) \(hourlyDay!) \(hourlyIcon!)")
                                
                    // bundling up the hours and putting the structs into an array
                        let hourlyForecast = HourlyForecast(tempC: tempC, tempF: tempF, hourlyCondition: hourlyCondition, hourlyHour: hourlyHour, hourlyDate: hourlyDate, hourlyTime: hourlyTime, hourlyDay: hourlyDay, hourlyIcon: hourlyIcon)
                                
                                self.hourlyData.append(hourlyForecast)
                                
                                if self.delegate != nil {
                                    self.delegate?.displayForecast(hourlyForecast)
                                }
                        
                            
                            }
                            
                            if self.delegate != nil {
                                self.delegate?.setWeather(currentWeather)
                                    
                            }
                    } else {
                        print("error parsing /posts/1")
                    }
                }
            }
        
        }
        
    }