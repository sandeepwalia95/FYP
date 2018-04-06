//
//  CSVViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 31/03/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI

class CSVViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var exportButton: UIButton!
    
    var ref: DatabaseReference!
    var databasehandle: DatabaseHandle?
    
    let defaults = UserDefaults.standard
    
    var logData = [Log]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        exportButton.layer.cornerRadius = 7.0
        exportButton.clipsToBounds = true
        
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
            self.logData.append(log)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for log in logData {
            print(log.activities)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func export(_ sender: Any) {
        let fileName = "Logs.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        let userFirstName = defaults.string(forKey: "firstNameKey")!
        let userlastName = defaults.string(forKey: "lastNameKey")!
        
        var csvText = "Name:\n\(userFirstName),\(userlastName)\n\nDate,Mood,Sleep,Alcohol,Work,Medication,Activities\n"
        
        for log in logData {
            let newLine = "\(log.date),\(log.mood),\(log.sleep),\(log.alcohol),\(log.work),\(log.medication)"
            csvText.append(newLine)
            
            if log.activities.count > 0 {
                csvText.append(",")
                for activity in log.activities {
                    csvText.append(activity)
                    csvText.append(",")
                }
            }
            csvText.append("\n")
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            
            if MFMailComposeViewController.canSendMail() {
                let emailController = MFMailComposeViewController()
                emailController.mailComposeDelegate = self
                emailController.setToRecipients([])
                emailController.setSubject("CSV Request")
                emailController.setMessageBody("Hello,\n\nAttached is a file containing \(userFirstName) \(userlastName)'s information.\n\nThis data is sent from the Mental Health Tracker app.", isHTML: false)
                
                emailController.addAttachmentData(NSData(contentsOf: path!)! as Data, mimeType: "text/csv", fileName: "Logs.csv")
                
                present(emailController, animated: true, completion: nil)
            }
            
        } catch {
            print("No file was created")
            print("\(error)")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
