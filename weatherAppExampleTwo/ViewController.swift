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
    
    var hourlyStuff = [String]()
    var hours = ["3", "3", "33"]
    
    let weatherService = WeatherService()
    
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
//            print(textField!.text!)
            
            // setting the entered text to the city label
            
//            self.cityLabel.text = textField!.text!
            
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
    
    func setWeather(currentWeather: CurrentWeather) {
        
        self.cityLabel.text = currentWeather.currentCityName
        self.currentConditionLabel.text = currentWeather.currentCondition
        self.currentTempLabel.text = ("\(currentWeather.currentTemp)")
     
    }
    
    func displayForecast(hourlyData: HourlyForecast) {
//        print(hourlyData)
        let hourlyData = [hourlyData]
        for hour in hourlyData {
//          print(hour)
            
            hourlyStuff.append("\(hour)")
            
        }
    
        

        for index in 0...hourlyData.count-1 {
//            print(hourlyData)
            for hour in hourlyData {
           let theHour = hourlyData[0].hourlyHour
                hours.append(theHour)
                }
            }
        
//        for hour in hourlyData {
////            print("this is the hour in the hourlyData inside the view controller \(hour)")
//           
////            if hour.hourlyDay == hourlyData[0].hourlyDay {
////                print(hour)
////            }
////            if hour.hourlyDate == hourlyData[0].hourlyDate && hour.hourlyHour == hourlyData[0].hourlyHour {
////                print(hour)
////            }
//        }
        
    
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherService.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
//    
//    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 5
//    }
//    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return hours.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        
        
        // Configure the cell
        
      
            cell.theHourLabel.text = self.hours[indexPath.row]
        
        return cell
    }
    
 
    func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            //1
            switch kind {
                //2
            case UICollectionElementKindSectionHeader:
                //3
                let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                    withReuseIdentifier: "header",
                    forIndexPath: indexPath)
                    as! CollectionReusableView
                return headerView
            default:
                //4
                assert(false, "Unexpected element kind")
            }
    }
    
    
    
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


