//
//  ViewLogsViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 03/02/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import DynamicColor
import FirebaseDatabase

class ViewLogsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var databasehandle: DatabaseHandle?
    
    var logData = [Log]()
    
    let dict: [String : AnyObject] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Ensure that there is no duplicates in the logs
        self.logData.removeAll()
        
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
            self.logData.insert(log, at: 0)
            
            // Reload the tableView to make sure new log is visible in the tableView.
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailLogSegue" {
            let selectedRow = self.tableView.indexPathForSelectedRow
            let destination = segue.destination as! DetailLogViewController
            destination.log = self.logData[selectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! ViewLogsViewControllerTableViewCell
        
        let row = indexPath.row
        let log = self.logData[row]
        
        cell.date.text = log.date
        
        let moodColor = moodToColor(mood: log.mood)
        cell.moodLabel.text = log.mood
        cell.firstMoodColor.backgroundColor = DynamicColor(hexString: moodColor)
        
        let displayActivities = activitiesFromLog(activities: log.activities)
        
        switch displayActivities.count {
        case 1:
            cell.activityOne.text = displayActivities[0]
            cell.activityTwo.text = " "
            cell.activityThree.text = " "
            cell.activityFour.text = " "
            cell.activityFive.text = " "
            cell.activitySix.text = " "
        case 2:
            cell.activityOne.text = displayActivities[0]
            cell.activityTwo.text = displayActivities[1]
            cell.activityThree.text = " "
            cell.activityFour.text = " "
            cell.activityFive.text = " "
            cell.activitySix.text = " "
        case 3:
            cell.activityOne.text = displayActivities[0]
            cell.activityTwo.text = displayActivities[1]
            cell.activityThree.text = displayActivities[2]
            cell.activityFour.text = " "
            cell.activityFive.text = " "
            cell.activitySix.text = " "
        case 4:
            cell.activityOne.text = displayActivities[0]
            cell.activityTwo.text = displayActivities[1]
            cell.activityThree.text = displayActivities[2]
            cell.activityFour.text = displayActivities[3]
            cell.activityFive.text = " "
            cell.activitySix.text = " "
        case 5:
            cell.activityOne.text = displayActivities[0]
            cell.activityTwo.text = displayActivities[1]
            cell.activityThree.text = displayActivities[2]
            cell.activityFour.text = displayActivities[3]
            cell.activityFive.text = displayActivities[4]
            cell.activitySix.text = " "
        case 6:
            cell.activityOne.text = displayActivities[0]
            cell.activityTwo.text = displayActivities[1]
            cell.activityThree.text = displayActivities[2]
            cell.activityFour.text = displayActivities[3]
            cell.activityFive.text = displayActivities[4]
            cell.activitySix.text = displayActivities[5]
        default:
            cell.activityOne.text = " "
            cell.activityTwo.text = " "
            cell.activityThree.text = " "
            cell.activityFour.text = " "
            cell.activityFive.text = " "
            cell.activitySix.text = " "
        }
        
        return cell
    }
    
    // Returns an array of string toi be displayed (max 6 activities)
    func activitiesFromLog(activities: [String]) -> [String] {
        var displayActivities = [String]()
        
        let activitiesLength = activities.count
        
        if (activitiesLength > 6) {
            for i in 0...5 {
                displayActivities.append(activities[i])
            }
            return displayActivities
        } else {
            return activities
        }
    }
    
    // Method to convert a string to a mood based on mood retrieved from Firebase within snapshot.
    func moodToColor(mood: String) -> String {
        
        let color: String
        switch mood {
        case "Excellent":
            color = "#976DD0"
        case "Great":
            color = "#00A6FF"
        case "Good":
            color = "#13CE66"
        case "Fair":
            color = "#E9F50C"
        case "Down":
            color = "#FFBA5C"
        case "Bad":
            color = "#F95F62"
        default:
            color = "#976DD0"
        }
        
        return color
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
