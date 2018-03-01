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
    
    var ref: DatabaseReference!
    var databasehandle: DatabaseHandle?
    
    var logData = [Log]()
    
    var moodData = [Double]()
    var sleepData = [Double]()
    var alcoholData = [Double]()
    var workData = [Double]()

    
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
            
            self.sleepData.append(Double(log.sleep))
            self.alcoholData.append(Double(log.alcohol))
            self.workData.append(Double(log.work))
            
            self.moodData.append(self.moodRangeConverter(moodValue: log.mood))
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        chart.removeAllSeries()
        
        chart.yLabels = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        
        let moodSeries = ChartSeries(moodData)
        moodSeries.color = ChartColors.yellowColor()
        moodSeries.area = true
        
        let sleepSeries = ChartSeries(sleepData)
        sleepSeries.color = ChartColors.blueColor()
        //sleepSeries.area = true
        
        let alcoholSeries = ChartSeries(alcoholData)
        alcoholSeries.color = ChartColors.redColor()
        //alcoholSeries.area = true
        
        let workSeries = ChartSeries(workData)
        workSeries.color = ChartColors.greenColor()
        //workSeries.area = true
        
        //let hours = ["jan", "feb", "mar"]
        
        //chart.xLabels = [0, 3, 6, 9, 12, 15, 18, 21, 24]
        //chart.xLabelsFormatter = { _,_ in "jan" }
//        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in return String(describing: (hours[labelIndex]))
//        }
        
        chart.add([moodSeries, sleepSeries, alcoholSeries, workSeries])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
