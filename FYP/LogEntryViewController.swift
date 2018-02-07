//
//  LogEntryViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 31/01/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import DynamicColor
import FirebaseDatabase

class LogEntryViewController: UIViewController {

    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var moodSlider: UISlider!
    @IBOutlet weak var sleepSlider: UISlider!
    @IBOutlet weak var alcoholSlider: UISlider!
    @IBOutlet weak var workSlider: UISlider!
    @IBOutlet weak var medicationSwitch: UISwitch!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button1.layer.cornerRadius = button1.bounds.size.width/2;
        button2.layer.cornerRadius = button2.bounds.size.width/2;
        button3.layer.cornerRadius = button3.bounds.size.width/2;
        button4.layer.cornerRadius = button4.bounds.size.width/2;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeMood(_ sender: Any) {
        moodSlider.value = roundf(moodSlider.value)
        
        switch moodSlider.value {
        case 1:
            moodLabel.text = "Excellent"
            moodLabel.backgroundColor = DynamicColor(hexString: "#976DD0")
            moodSlider.thumbTintColor = DynamicColor(hexString: "#976DD0")
        case 2:
            moodLabel.text = "Great"
            moodLabel.backgroundColor = DynamicColor(hexString: "#00A6FF")
            moodSlider.minimumTrackTintColor = DynamicColor(hexString: "#00A6FF")
            moodSlider.thumbTintColor = DynamicColor(hexString: "#00A6FF")
        case 3:
            moodLabel.text = "Good"
            moodLabel.backgroundColor = DynamicColor(hexString: "#13CE66")
            moodSlider.minimumTrackTintColor = DynamicColor(hexString: "#13CE66")
            moodSlider.thumbTintColor = DynamicColor(hexString: "#13CE66")
        case 4:
            moodLabel.text = "Fair"
            moodLabel.backgroundColor = DynamicColor(hexString: "#E9F50C")
            moodSlider.minimumTrackTintColor = DynamicColor(hexString: "#E9F50C")
            moodSlider.thumbTintColor = DynamicColor(hexString: "#E9F50C")
        case 5:
            moodLabel.text = "Uh-Oh"
            moodLabel.backgroundColor = DynamicColor(hexString: "#FFBA5C")
            moodSlider.minimumTrackTintColor = DynamicColor(hexString: "#FFBA5C")
            moodSlider.thumbTintColor = DynamicColor(hexString: "#FFBA5C")
        case 6:
            moodLabel.text = "Bad"
            moodLabel.backgroundColor = DynamicColor(hexString: "#F95F62")
            moodSlider.minimumTrackTintColor = DynamicColor(hexString: "#F95F62")
            moodSlider.thumbTintColor = DynamicColor(hexString: "#F95F62")
        default:
            moodLabel.text = "Great"
            moodLabel.backgroundColor = DynamicColor(hexString: "#00A6FF")
            moodSlider.minimumTrackTintColor = DynamicColor(hexString: "#00A6FF")
            moodSlider.thumbTintColor = DynamicColor(hexString: "#00A6FF")
        }
    }
    
    @IBAction func selectSleep(_ sender: Any) {
        sleepSlider.value = roundf(sleepSlider.value)
        
        sleepLabel.text = Int(sleepSlider.value).description + " hrs"
        
        let timeInterval = NSDate().timeIntervalSince1970
        print(timeInterval)
        
    }
    
    
    @IBAction func selectAlcohol(_ sender: Any) {
        alcoholSlider.value = roundf(alcoholSlider.value)
        
        alcoholLabel.text = Int(alcoholSlider.value).description + " units"
        
        let date = NSDate(timeIntervalSince1970: 1517955151)
        print(date)
    }
    
    @IBAction func alcoholInfo(_ sender: Any) {
        displayAlertMessage(alertMessage: "Beer(pint): 2 units \n Spirts(25ml): 1 unit \n Wine(175ml): 2 units")
    }
    
    @IBAction func selectWork(_ sender: Any) {
        workSlider.value = roundf(workSlider.value)
        
        workLabel.text = Int(workSlider.value).description + " hrs"
    }
    
    @IBAction func logPressed(_ sender: Any) {
//        let timeInterval = NSDate().timeIntervalSince1970
//        let timeIntervalString = String (Int(timeInterval))
//        print(timeIntervalString)
//
//        ref.child(timeIntervalString).child("mood").setValue(moodLabel.text)
        
        // Create a child in the 'logs' branch with the child being the current date.
        // Then branch another child off this and set the first parameter value (mood)
        // to the value taken from the moodSlider.
        let logBranch = ref.child("logs")
        logBranch.child(getCurrentDate()).child("mood").setValue(moodLabel.text)
        
        logBranch.child(getCurrentDate()).child("sleep").setValue(sleepSlider.value)
        
        logBranch.child(getCurrentDate()).child("alcohol").setValue(alcoholSlider.value)
        
        logBranch.child(getCurrentDate()).child("work").setValue(workSlider.value)
        
        var medValue = false
        if (medicationSwitch.isOn) {
            medValue = true
        }
        
        logBranch.child(getCurrentDate()).child("medication").setValue(medValue)
    }
    
    func logMedication() {
        
    }
    
    func displayAlertMessage(alertMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alcohol Unit Information \n", message: alertMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        print(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let currDate = formatter.string(from: date)
        print(currDate)
        return currDate
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
