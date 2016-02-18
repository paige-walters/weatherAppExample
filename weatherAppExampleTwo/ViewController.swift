//
//  ViewController.swift
//  weatherAppExampleTwo
//
//  Created by Paige Walters on 1/30/16.
//  Copyright © 2016 Paige Walters. All rights reserved.
//


import UIKit
import Alamofire

class ViewController: UIViewController, WeatherServiceDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let warmColor = UIColor(0xFF9800)
    let coolColor = UIColor(0x03A9F4)
    
    private let reuseIdentifier = "cell"
    
    var hourlyStuff = [HourlyForecast]()
    var dailyInfo = [[HourlyForecast]]()
    
    var firstDay = [HourlyForecast]()
    var secondDay = [HourlyForecast]()
    var thirdDay = [HourlyForecast]()
    var fourthDay = [HourlyForecast]()
    var fithDay = [HourlyForecast]()
    var sixthDay = [HourlyForecast]()
    var seventhDay = [HourlyForecast]()
  
   
    
    let weatherService = WeatherService()
    
    @IBOutlet var myView: UIView!
    
    @IBOutlet weak var collectionOutlet: MyCollectionView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var currentConditionLabel: UILabel!
    
    @IBAction func enterZipButton(sender: UIButton) {
        openZipAlert()
    }
    

    
    
    func openZipAlert() {
        
        let zipAlert = UIAlertController(title: "Zip", message: "Enter in your zip", preferredStyle: UIAlertControllerStyle.Alert)
        
        // create ok action
        let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            print("ok")
            
            let textField = zipAlert.textFields?[0]
            
            let zipEntered = textField!.text!
            
            self.weatherService.getWeatherForZip(zipEntered)
            
        }
        
        zipAlert.addAction(ok)
        
        // create cancel action
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        zipAlert.addAction(cancel)
        
        // add text field
        
        zipAlert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "Zip Code"
        }
        
        // present alert controller
        self.presentViewController(zipAlert, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Weather Service Delegate
    
    //    setting the current weather labels
    func setWeather(currentWeather: CurrentWeather) {
      
        self.cityLabel.text = currentWeather.currentCityName
        self.currentConditionLabel.text = currentWeather.currentCondition
        self.currentTempLabel.text = ("\(Int(currentWeather.currentTemp))˚")
    
       if currentWeather.currentTemp < 60 {
            self.myView.backgroundColor = coolColor
        } else {
            self.myView.backgroundColor = warmColor
        }
     
    }
    
    
    func displayForecast(hourlyData: [HourlyForecast]) {
        hourlyStuff = hourlyData
        let convertHourToInt = hourlyStuff[0].hourlyDate
        let hourItt = Int(convertHourToInt)!
  
        
   
//        for hour in hourlyStuff[0...7] {
//            print("This should only have 7 things \(hour)")
//        }
//        
        for hour in hourlyStuff {
//            let hourlyHour = hour.hourlyHour
//            let numberHour = Int(hourlyHour)
//            
            if hour.hourlyDay == hourlyStuff[0].hourlyDay && hour.hourlyDate == convertHourToInt {
                firstDay.append(hour)
               
            } else if Int(hour.hourlyDate) == hourItt + 1  {
                secondDay.append(hour)
               
            } else if Int(hour.hourlyDate) == hourItt + 2 {
                thirdDay.append(hour)
                
            } else if Int(hour.hourlyDate) == hourItt + 3 {
                fourthDay.append(hour)
            } else if Int(hour.hourlyDate) == hourItt + 4 {
                fithDay.append(hour)
            } else if Int(hour.hourlyDate) == hourItt + 5 {
                sixthDay.append(hour)
            } else if Int(hour.hourlyDate) == hourItt + 6 {
                seventhDay.append(hour)
            }
            else {
//                print("Else statment in the hourly Stuff")
            }
        }
        
        dailyInfo.append(firstDay)
        dailyInfo.append(secondDay)
        dailyInfo.append(thirdDay)
        dailyInfo.append(fourthDay)
        dailyInfo.append(fithDay)
        dailyInfo.append(sixthDay)
        dailyInfo.append(seventhDay)
        
        var maxTemp = firstDay[0].tempF
        var minTemp = firstDay[0].tempF
        for temp in firstDay {
            if maxTemp < temp.tempF {
                maxTemp = temp.tempF
            }
        }
        for temp in firstDay {
            if minTemp > temp.tempF {
                minTemp = temp.tempF
            }
        }
            print(firstDay)
            print("This is min Temp \(minTemp)")
             print("This is max Temp \(maxTemp)")
    
//        let maxTemp = maxElement(firstDay.map{$0.tempF})
        
//        print(maxTemp)
        
//        let maxTemp = maxElement()
        
//        print("****vthis is the daily info \(dailyInfo[0])")
   
         self.collectionOutlet.reloadData()
        
    }

        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherService.delegate = self
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UICollectionViewDataSource
    

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 7
    }
 
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0  && firstDay.count < 8 {
        return firstDay.count
        } else if hourlyStuff.count >= 8 {
            return(8)
        } else {
            return hourlyStuff.count
        }
        
//        self.dailyInfo[section].count
        
//        print(hourlyStuff.count)
//         var dayNumber = 0
//        for day in dailyInfo {
//           print(day)
//        if day.count < 8 {
//            dayNumber = 8
//            return dayNumber
//        } else if day.count == 0 {
//            dayNumber = 0
//           return dayNumber
//        } else {
//            dayNumber = day.count
//            return dayNumber
//        }
//  
//    }
//        return dayNumber
//    }
//   
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        
        
        // Configure the cell
        // set the cell to have the proper hour icon and temp
        
//        cell.theHourLabel.text = self.hourlyStuff[indexPath.row].hourlyTime
//        cell.theTempLabel.text = self.hourlyStuff[indexPath.row].tempF + "˚"
  
//        cell.theHourLabel.text = self.firstDay[indexPath.row].hourlyTime
//        cell.theTempLabel.text = self.firstDay[indexPath.row].tempF + "˚"
//        print("this is the \(self.dailyInfo[indexPath.section][indexPath.row].hourlyTime)")
        
            cell.theHourLabel.text = self.dailyInfo[indexPath.section][indexPath.row].hourlyTime
            cell.theTempLabel.text = self.dailyInfo[indexPath.section][indexPath.row].tempF + "˚"
    

        let iconString = dailyInfo[indexPath.section][indexPath.row].hourlyIcon
        let iconSubstring = iconString.componentsSeparatedByString("/k/")
        let iconStringDismantled = iconSubstring[1].componentsSeparatedByString(".gif")
        let iconStringUsing = iconStringDismantled[0]
//        let iconSubstring = iconString.characters.split{ $0 == "k"}.map(String.init)
    
        
//        let iconSubstring = iconString.substringWithRange(Range<String.Index>(start: iconString.startIndex.advancedBy(31), end: iconString.endIndex.advancedBy(-4)))
//        print("this is the substring \(iconSubstring)")

      let stringIconUrl = ("\(iconStringUsing.nrd_weatherIconURL()!)")
        print(stringIconUrl)
        
        cell.hourlyIcon.image = UIImage(data: NSData(contentsOfURL: NSURL(string: stringIconUrl)!)!)

        
        
        cell.setNeedsDisplay()
       
        
        return cell
    }
    
    
 
    func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            
            switch kind {
                
            case UICollectionElementKindSectionHeader:
                
                let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                    withReuseIdentifier: "header",
                    forIndexPath: indexPath)
                    as! CollectionReusableView
                
                // setting the header to the human readable day of the week
                // still need to implement logic for today or tomorrow
                
                if dailyInfo.count == 0 {
                    headerView.headerLabel.text = "Day"
                } else if self.dailyInfo[indexPath.section][indexPath.row].hourlyDate == firstDay[0].hourlyDate {
                     headerView.headerLabel.text = "Today"
                } else if self.dailyInfo[indexPath.section][indexPath.row].hourlyDate == secondDay[0].hourlyDate {
                    headerView.headerLabel.text = "Tomorrow"
                } else {
                headerView.headerLabel.text = self.dailyInfo[indexPath.section][indexPath.row].hourlyDay
                }
                
                return headerView
                
            default:
                assert(false, "Unexpected element kind")
            }
    }
    
    
//    override func viewWillAppear(animated: Bool) {
//        MyCollectionView.reloadData()
//    }
    
    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
}


