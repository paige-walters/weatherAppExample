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
    
    var hourlyStuff = [HourlyForecast]()
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
        self.currentTempLabel.text = ("\(currentWeather.currentTemp)")
     
    }
    
    
    func displayForecast(hourlyData: [HourlyForecast]) {
        hourlyStuff = hourlyData

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
    

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
 
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return hourlyStuff.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        
        
        // Configure the cell
        
      
//        cell.theHourLabel.text = self.hours[indexPath.row]
        
        cell.theHourLabel.text = self.hourlyStuff[indexPath.row].hourlyHour
        
        cell.setNeedsDisplay()
        
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


