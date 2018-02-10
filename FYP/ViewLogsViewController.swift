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
    
    let list = ["Milk", "Cheese", "Bread"]
    
    var logData = [Log]()
    
    let dict: [String : AnyObject] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
            
            //self.logData.append(snapshot.children)
//            let allData = snapshot.children.allObjects
//            for i in allData {
//                print(i)
//            }
            
            // Pick up from here tomorrow....
            // We can get all the normal keys by just going through the dataDict
            // And use the method below to access the keys within activities
            var dataDict = snapshot.value as? [String : Any]
            print(dataDict)
            
            print(snapshot.key)
            
            let logDate = snapshot.key
            let logMood = dataDict!["mood"] as! String
            print(logMood)
            
            
            let log = Log(date: logDate, mood: logMood)
            self.logData.append(log)
            print(self.logData)
            
            self.tableView.reloadData()
            
//            print("Wooooohooooo")
//            var actDict = snapshot.childSnapshot(forPath: "activities").value as? [String : Any]
//            print(actDict)
//
//            for x in actDict! {
//                print(x.key)
//            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        return cell
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
        case "Uh-Oh":
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
