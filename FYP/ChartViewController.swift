//
//  ChartViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 28/02/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import SwiftChart
import FirebaseDatabase
import MBCircularProgressBar
import DynamicColor
import HealthKit
import GTProgressBar

class ChartViewController: UIViewController {

    @IBOutlet weak var chart: Chart!
    
    @IBOutlet weak var daysSegmentController: UISegmentedControl!
    
    @IBOutlet weak var sleepProgressView: MBCircularProgressBarView!
    @IBOutlet weak var alcoholProgressView: MBCircularProgressBarView!
    @IBOutlet weak var workProgressView: MBCircularProgressBarView!
    @IBOutlet weak var moodProgressMeter: GTProgressBar!
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var stepsProgressMeter: GTProgressBar!
    
    var ref: DatabaseReference!
    var databasehandle: DatabaseHandle?
    
    var logData = [Log]()
    
    var moodData = [Double]()
    var sleepData = [Double]()
    var alcoholData = [Double]()
    var workData = [Double]()
    var dateData = [String]()

    var moodSeven = [Double]()
    var sleepSeven = [Double]()
    var alcoholSeven = [Double]()
    var workSeven = [Double]()
    var dateSeven = [String]()
    
    let healthStore = HKHealthStore()
    
    var allSteps = [HKQuantitySample]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.sleepProgressView.value = 0
        self.sleepProgressView.progressColor = UIColor.blue
        self.sleepProgressView.progressStrokeColor = UIColor.blue
        
        self.alcoholProgressView.value = 0
        self.alcoholProgressView.progressColor = UIColor.red
        self.alcoholProgressView.progressStrokeColor = UIColor.red
        
        self.workProgressView.value = 0
        self.workProgressView.progressColor = UIColor.green
        self.workProgressView.progressStrokeColor = UIColor.green
        
        self.moodProgressMeter.barFillColor = DynamicColor(hexString: "#976DD0")
        self.moodProgressMeter.animateTo(progress: 20)
        
        // Set Firebase reference
        ref = Database.database().reference()
        
        // Retrieve the "logs" and listen for changes
        // 'snapshot' will observe the node "logs" --> goes through all of the
        // children of "logs" and fires the below code for each child.
        // Observe returns a 'UInt'
        databasehandle = ref?.child("logs").observe(.childAdded, with: { (snapshot) in
            
            // Code to execute when a child is added under "logs"
            // take the value from the snapshot and add it to the 'logData' array.
            // Only fired when a new child is added.
            // We are responsible for detaching the listener.
            // UInt is a reference to the particular reference that we have open here
            // so we can use it to detach the listener.
            
            var dataDict = snapshot.value as? [String : Any]
            
            // Extract data from the dictionary (snapshot)
            let logDate = snapshot.key
            let logMood = dataDict!["mood"] as! String
            let logSleep = dataDict!["sleep"] as! Int
            let logAlcohol = dataDict!["alcohol"] as! Int
            let logWork = dataDict!["work"] as! Int
            let logMedication = dataDict!["medication"] as! Bool
            
            var logActivities = [String]()
            
            // If activities have been logged then extract them from the dictionary (snapshot)
            if (dataDict!["activities"] != nil) {
                logActivities = dataDict!["activities"] as! [String]
            }
            
            // Create log object and add it to the LogDate list which will be accessed with the tableView methods.
            let log = Log(date: logDate, mood: logMood, sleep: logSleep, alcohol: logAlcohol, work: logWork, medication: logMedication, activities: logActivities)
            self.logData.append(log)
            
            self.moodData.append(self.moodRangeConverter(moodValue: log.mood))
            self.sleepData.append(Double(log.sleep))
            self.alcoholData.append(Double(log.alcohol))
            self.workData.append(Double(log.work))
            
            self.dateData.append(self.dateSubString(date: log.date))
        })
        
        let numDays = 7
        if checkAvailability() {
            var scount: Int = 0
            getSteps(days: numDays) { (steps, error) in
                scount = Int(steps)
                print("Scount  \(scount)")
                print("Scount  \(scount/numDays)")
                let averageSteps = scount/numDays
                let progress = Double(averageSteps)/Double(12000)
                print(progress)
                self.stepsLabel.text = String("\(averageSteps) steps")
                self.stepsProgressMeter.animateTo(progress: CGFloat(progress))
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (daysSegmentController.selectedSegmentIndex == 0) {
            setChartData(suffixValue: 30, fontValue: 8)
        } else if (daysSegmentController.selectedSegmentIndex == 1) {
            setChartData(suffixValue: 7, fontValue: 10)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        self.stepsLabel.isHidden = true
        
        var numDays = 7
        
        if (daysSegmentController.selectedSegmentIndex == 0) {
            setChartData(suffixValue: 30, fontValue: 8)
            numDays = 30
        } else if (daysSegmentController.selectedSegmentIndex == 1) {
            setChartData(suffixValue: 7, fontValue: 10)
            numDays = 7
        }
        
        if checkAvailability() {
            var scount: Int = 0
            getSteps(days: numDays) { (steps, error) in
                scount = Int(steps)
                print("Scount  \(scount)")
                print("Scount  \(scount/numDays)")
                let averageSteps = scount/numDays
                let progress = Double(averageSteps)/Double(12000)
                print(progress)
                self.stepsLabel.text = String("\(averageSteps) steps")
                self.stepsProgressMeter.animateTo(progress: CGFloat(progress))
            }
        }
    }
    
    func setChartData(suffixValue: Int, fontValue: Double) {
        
        // Clear all series to ensure blank graph
        chart.removeAllSeries()
        
        // Retrieve data for all series and use ArraySlice to cut down amount
        // of data based on how many days required
        let moodSuffixData = self.moodData.suffix(suffixValue)
        self.moodSeven = Array(moodSuffixData)
        
        let sleepSuffixData = self.sleepData.suffix(suffixValue)
        self.sleepSeven = Array(sleepSuffixData)
        
        let alcoholSuffixData = self.alcoholData.suffix(suffixValue)
        self.alcoholSeven = Array(alcoholSuffixData)
        
        let workSuffixData = self.workData.suffix(suffixValue)
        self.workSeven = Array(workSuffixData)
        
        let dateSuffixData = self.dateData.suffix(suffixValue)
        self.dateSeven = Array(dateSuffixData)
        
        // Animate the progressViews
        UIView.animate(withDuration: 1.0) {
            var arraySumSleep = self.sleepSeven.reduce(0) { $0 + $1 }
            arraySumSleep = arraySumSleep/Double(self.sleepSeven.count)
            self.sleepProgressView.value = CGFloat(arraySumSleep)
            
            var arraySumAlcohol = self.alcoholSeven.reduce(0) { $0 + $1 }
            arraySumAlcohol = arraySumAlcohol/Double(self.alcoholSeven.count)
            self.alcoholProgressView.value = CGFloat(arraySumAlcohol)
            
            var arraySumWork = self.workSeven.reduce(0) { $0 + $1 }
            arraySumWork = arraySumWork/Double(self.workSeven.count)
            self.workProgressView.value = CGFloat(arraySumWork)
            
            var arraySumMood = self.moodSeven.reduce(0) { $0 + $1 }
            arraySumMood = arraySumMood/Double(self.moodSeven.count)
            self.moodProgressMeter.animateTo(progress: CGFloat(arraySumMood/20))
            self.changeMoodProgressColorLabel(moodValue: Float(arraySumMood))
        }
        
        // Set up y-axis values
        chart.yLabels = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        
        // Chamge font and orientation of x-axis values based on values required
        chart.labelFont = UIFont (name: "Helvetica Neue", size: CGFloat(fontValue))
        chart.xLabelsOrientation = .vertical
        
        // Change the orientation of the labels to horizontal if showing '7-days'
        if (fontValue == 10) {
            chart.xLabelsOrientation = .horizontal
        }
        
        // Set the data to the ChartSeries
        let moodSeries = ChartSeries(moodSeven)
        moodSeries.color = ChartColors.yellowColor()
        moodSeries.area = true
        
        let sleepSeries = ChartSeries(sleepSeven)
        sleepSeries.color = ChartColors.blueColor()
        
        let alcoholSeries = ChartSeries(alcoholSeven)
        alcoholSeries.color = ChartColors.redColor()
        
        let workSeries = ChartSeries(workSeven)
        workSeries.color = ChartColors.greenColor()
        
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return String(describing: (self.dateSeven[labelIndex]))
        }
        
        // Add all of the series to the charts
        chart.add([moodSeries, sleepSeries, alcoholSeries, workSeries])
    }
    
    // Calculate value of mood to range between 0 and 20
    func moodRangeConverter(moodValue: String) -> Double {
        
        switch moodValue {
        case "Excellent":
            return 20.0
        case "Great":
            return ((20.0/6) * 5)
        case "Good":
            return ((20.0/6) * 4)
        case "Fair":
            return ((20.0/6) * 3)
        case "Uh-Oh":
            return ((20.0/6) * 2)
        case "Bad":
            return ((20.0/6) * 1)
        default:
            return 20.0
        }
    }
    
    // Return a shortened form of the date for chart
    func dateSubString(date: String) -> String {
        return String(date.prefix(5))
    }
    
    // Change value of progressBar for mood
    func changeMoodProgressColorLabel(moodValue: Float) {
        var progressColor: UIColor
        var mood: String
        
        if (moodValue <= (20.0/6) * 1) {
            progressColor = DynamicColor(hexString: "#F95F62")
            mood = "Bad"
        } else if (moodValue <= (20.0/6) * 2) {
            progressColor = DynamicColor(hexString: "#FFBA5C")
            mood = "Uh-Oh"
        } else if (moodValue <= (20.0/6) * 3) {
            progressColor = DynamicColor(hexString: "#E9F50C")
            mood = "Fair"
        } else if (moodValue <= (20.0/6) * 4) {
            progressColor = DynamicColor(hexString: "#13CE66")
            mood = "Good"
        } else if (moodValue <= (20.0/6) * 5) {
            progressColor = DynamicColor(hexString: "#00A6FF")
            mood = "Great"
        } else {
            progressColor = DynamicColor(hexString: "#976DD0")
            mood = "Excellent"
        }
        
        self.moodProgressMeter.barFillColor = progressColor
        self.moodLabel.text = mood
    }
    
    func checkAvailability() -> Bool {
        
        var isAvailable = true
        
        // Is HealthKit data available on this type of device?
        if HKHealthStore.isHealthDataAvailable() {
            
            print("HealthKit data available")
            
            let stepCounter = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) as Any)
            
            healthStore.requestAuthorization(toShare: nil, read: stepCounter as? Set<HKObjectType>, completion: { (success, error) in
                
                isAvailable = success
            })
            
            print("Authorization has been granted")
            
        } else {
            isAvailable = false
            print("HealthKit data is not available")
        }
        
        return isAvailable
    }
    
    func getSteps(days: Int, completion: @escaping (Double, NSError?) -> () ) {
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let calendar = Calendar.current
        let twoDaysAgo = calendar.date(byAdding: .day, value: -(days), to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: twoDaysAgo, end: Date(), options: [])
        
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { (query, results, error) in
            
            var steps: Double = 0
            
            if results!.count > 0 {
                self.allSteps = results as! [HKQuantitySample]
                for step in self.allSteps {
                    steps += step.quantity.doubleValue(for: HKUnit.count())
                }
            }
            self.activityIndicator.isHidden = true
            self.stepsLabel.isHidden = false
            self.activityIndicator.stopAnimating()
            
            completion(steps, error as NSError?)
        }
        healthStore.execute(query)
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Return the the current date in the format below
    // *** TODO: Change the format of how the date is presented
    func justDate(date: Date) -> String {
        let newDate = String(describing: date)
        return String(newDate.prefix(10))
    }
}
