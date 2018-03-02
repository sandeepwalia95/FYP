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

class ChartViewController: UIViewController {

    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var daysSegmentController: UISegmentedControl!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        if (daysSegmentController.selectedSegmentIndex == 0) {
            setChartData(suffixValue: 30, fontValue: 8)
        } else if (daysSegmentController.selectedSegmentIndex == 1) {
            setChartData(suffixValue: 7, fontValue: 10)
        }
    }
    func setChartData(suffixValue: Int, fontValue: Double) {
        
        // Clear all series to ensure blank graph
        chart.removeAllSeries()
        
        // Retrieve data for all series and use ArraySlice to cut down amount
        // of data based on how many days required
        let moodSuffixData = self.moodData.suffix(suffixValue)
        self.moodSeven = Array(moodSuffixData)
        print(self.moodSeven.capacity)
        
        let sleepSuffixData = self.sleepData.suffix(suffixValue)
        self.sleepSeven = Array(sleepSuffixData)
        print(self.sleepSeven.capacity)
        
        let alcoholSuffixData = self.alcoholData.suffix(suffixValue)
        self.alcoholSeven = Array(alcoholSuffixData)
        print(self.alcoholSeven.capacity)
        
        let workSuffixData = self.workData.suffix(suffixValue)
        self.workSeven = Array(workSuffixData)
        print(self.workSeven.capacity)
        
        let dateSuffixData = self.dateData.suffix(suffixValue)
        self.dateSeven = Array(dateSuffixData)
        
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
        
        //let hours = ["jan", "feb", "mar"]
        
        //chart.xLabels = [0, 3, 6, 9, 12, 15, 18, 21, 24]
        //chart.xLabelsFormatter = { _,_ in "jan" }
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return String(describing: (self.dateSeven[labelIndex]))
        }
        
        // Add all of the series to the charts
        chart.add([moodSeries, sleepSeries, alcoholSeries, workSeries])
    }
    
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
    
    func dateSubString(date: String) -> String {
        return String(date.prefix(5))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}