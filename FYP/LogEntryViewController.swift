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
import fluid_slider
import Whisper

class LogEntryViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    
    @IBOutlet weak var alcoholInfo: UIButton!
    
    @IBOutlet weak var moodSlider: Slider!
    @IBOutlet weak var sleepSlider: Slider!
    @IBOutlet weak var alcoholSlider: Slider!
    @IBOutlet weak var workSlider: Slider!
    
    var moodValue = "Excellent"
    var sleepValue = 0
    var alcoholValue = 0
    var workValue = 0
    
    @IBOutlet weak var medicationSwitch: UISwitch!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    
    var ref: DatabaseReference!
    
    var activityButtons: [UIButton] = []
    var activitiesSelected: [String] = []
    
    let defaults = UserDefaults.standard
    
    var logText: String? = "No note added"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Button UI
        setupActivityButtons()
        
        // Button title
        setActivityButtonTitles()
        
        setFluidSlider(slider: moodSlider, maxVal: 5, minLabel: "Excellent", maxLabel: "Bad", color: DynamicColor(hexString: "#13CE66"))
        setFluidSlider(slider: sleepSlider, maxVal: 10, minLabel: "0", maxLabel: "10+", color: UIColor.blue)
        setFluidSlider(slider: alcoholSlider, maxVal: 20, minLabel: "0", maxLabel: "20+", color: UIColor.red)
        setFluidSlider(slider: workSlider, maxVal: 10, minLabel: "0", maxLabel: "10+", color: UIColor.green)
        
        logButton.layer.cornerRadius = 8
        noteButton.layer.cornerRadius = 8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Button title
        setActivityButtonTitles()
        
        // Set Firebase reference
        ref = Database.database().reference()
        
        // Ensure no previous activities are being included
        activitiesSelected.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Change activity button color and selected attribute
    @IBAction func activityPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                button.backgroundColor = UIColor.lightGray
                button.tintColor = UIColor.lightGray
            } else {
                // set selected
                button.isSelected = true
                button.backgroundColor = DynamicColor(hexString: "#85C1E9")
                button.tintColor = DynamicColor(hexString: "#85C1E9")
            }
        }
    }
    
    // Display Alcohol information for units
    @IBAction func alcoholInfo(_ sender: Any) {
        displayAlertMessage(alertMessage: "Beer(pint): 2 units \n Spirts(25ml): 1 unit \n Wine(175ml): 2 units")
    }
    
    @IBAction func logPressed(_ sender: Any) {
        
        // Checks if the medication switch is on or not
        var medValue = false
        if (medicationSwitch.isOn) {
            medValue = true
        }
        
        // Method to check what activites have been selected by the user.
        checkActivitiesSelected()
        
        // Create a child in the 'logs' branch with the child being the current date.
        // Then branch another child off this and set the parameter values.
        
        // ** NB -> Need to set these values in one go to avoid error of nil being read when this
        // is being observed in the ViewLogs VC **
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let logBranch = ref.child("allLogs").child(uuid!)
        logBranch.child(getCurrentDate()).setValue(["mood" : moodValue,
                                                    "sleep" : sleepValue,
                                                    "alcohol" : alcoholValue,
                                                    "work" : workValue,
                                                    "medication" : medValue,
                                                    "activities" : activitiesSelected,
                                                    "note" : logText])
        
        tabBarController?.selectedIndex = 0
        
        var murmur = Murmur(title: "Logged Successfully...")
        murmur.backgroundColor = DynamicColor(hexString: "85C1E9")
        
        // Show and hide a message after delay
        Whisper.show(whistle: murmur, action: .show(3))
        
        logText = "No note added"
    }
    
    @IBAction func addNote(_ sender: Any) {
        let alertController = UIAlertController(title: "Add a Note \n\n\n\n\n\n\n\n\n", message: "", preferredStyle: .alert)
        
        let point = CGPoint(x: 15,y: 50)
        let rect = CGRect(origin: point, size: CGSize(width: 240, height: 180))
        //let rect        = CGRectMake(15, 50, 240, 150.0)
        let textView    = UITextView(frame: rect)
        
        textView.font               = UIFont(name: "Helvetica", size: 15)
        textView.backgroundColor    = UIColor.white
        textView.layer.borderColor  = UIColor.lightGray.cgColor
        textView.layer.borderWidth  = 1.0
        textView.delegate           = self
        
        alertController.view.addSubview(textView)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            let note = textView.text
            self.logText = note
        })
        alertController.addAction(cancel)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: {})
    }
    // Method to check what activities have been selected by the user
    func checkActivitiesSelected() {
        
        for button in activityButtons {
            if (button.isSelected) {
                // Only add the activity to the list if it hasn't already been added (prevent duplicates)
                if (activitiesSelected.contains((button.titleLabel?.text)!) == false) {
                    activitiesSelected.append((button.titleLabel?.text)!)
                }
            }
        }
    }
    
    // Alert message to display the Alcohol Unit Information
    func displayAlertMessage(alertMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alcohol Unit Information \n", message: alertMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // Return the the current date in the format below
    // *** TODO: Change the format of how the date is presented
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let currDate = formatter.string(from: date)
        return currDate
    }
    
    // Setup the buttons as circular and add them to an array.
    func setupActivityButtons() {
        button1.layer.cornerRadius = button1.bounds.size.width/2;
        button2.layer.cornerRadius = button2.bounds.size.width/2;
        button3.layer.cornerRadius = button3.bounds.size.width/2;
        button4.layer.cornerRadius = button4.bounds.size.width/2;
        button5.layer.cornerRadius = button5.bounds.size.width/2;
        button6.layer.cornerRadius = button6.bounds.size.width/2;
        button7.layer.cornerRadius = button7.bounds.size.width/2;
        button8.layer.cornerRadius = button8.bounds.size.width/2;
        button9.layer.cornerRadius = button9.bounds.size.width/2;
        button10.layer.cornerRadius = button10.bounds.size.width/2;
        button11.layer.cornerRadius = button11.bounds.size.width/2;
        button12.layer.cornerRadius = button12.bounds.size.width/2;
        
        activityButtons.append(button1)
        activityButtons.append(button2)
        activityButtons.append(button3)
        activityButtons.append(button4)
        activityButtons.append(button5)
        activityButtons.append(button6)
        activityButtons.append(button7)
        activityButtons.append(button8)
        activityButtons.append(button9)
        activityButtons.append(button10)
        activityButtons.append(button11)
        activityButtons.append(button12)
    }
    
    // Set the titles of the activity buttons
    func setActivityButtonTitles() {
        button1.setTitle(defaults.string(forKey: "actOne"), for: .normal)
        button2.setTitle(defaults.string(forKey: "actTwo"), for: .normal)
        button3.setTitle(defaults.string(forKey: "actThree"), for: .normal)
        button4.setTitle(defaults.string(forKey: "actFour"), for: .normal)
        button5.setTitle(defaults.string(forKey: "actFive"), for: .normal)
        button6.setTitle(defaults.string(forKey: "actSix"), for: .normal)
        button7.setTitle(defaults.string(forKey: "actSeven"), for: .normal)
        button8.setTitle(defaults.string(forKey: "actEight"), for: .normal)
        button9.setTitle(defaults.string(forKey: "actNine"), for: .normal)
        button10.setTitle(defaults.string(forKey: "actTen"), for: .normal)
        button11.setTitle(defaults.string(forKey: "actEleven"), for: .normal)
        button12.setTitle(defaults.string(forKey: "actTwelve"), for: .normal)
    }
    
    // Initialise and set up the sliders
    func setFluidSlider(slider: Slider, maxVal: CGFloat, minLabel: String, maxLabel: String, color: UIColor) {
        
        let labelTextAttributes: [NSAttributedStringKey : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        slider.attributedTextForFraction = { fraction in
            var fontSize = 12
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            var string = formatter.string(from: (fraction * maxVal) as NSNumber) ?? ""
            
            if slider.accessibilityIdentifier == "sleep" {
                self.sleepValue = Int(string)!
            } else if slider.accessibilityIdentifier == "alcohol" {
                self.alcoholValue = Int(string)!
            } else if slider.accessibilityIdentifier == "work" {
                self.workValue = Int(string)!
            } else if slider.accessibilityIdentifier == "mood" {
                string = self.fluidMoodString(string: string, slider: slider)
                // Must change font size due to 'excellent' taking up a larger space
                fontSize = 10
                if string == "Excellent" {
                    fontSize = 7
                }
            }
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: CGFloat(fontSize), weight: .bold), .foregroundColor: UIColor.black])
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: minLabel, attributes: labelTextAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: maxLabel, attributes: labelTextAttributes))
        slider.fraction = 0.5
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = color
        slider.valueViewColor = .white
        slider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(slider: slider, true, animated: true)
        }
        slider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(slider: slider, false, animated: true)
        }
    }
    
    // Hides label when user interacts with slider
    private func setLabelHidden(slider: Slider, _ hidden: Bool, animated: Bool) {
        let animations = {
            if slider.accessibilityIdentifier == "sleep" {
                self.sleepLabel.alpha = hidden ? 0 : 1
            } else if slider.accessibilityIdentifier == "alcohol" {
                self.alcoholLabel.alpha = hidden ? 0 : 1
                self.alcoholInfo.alpha = hidden ? 0 : 1
            } else if slider.accessibilityIdentifier == "work" {
                self.workLabel.alpha = hidden ? 0 : 1
            } else if slider.accessibilityIdentifier == "mood" {
                self.moodLabel.alpha = hidden ? 0 : 1
            }
        }
        if animated {
            UIView.animate(withDuration: 0.1, animations: animations)
        } else {
            animations()
        }
    }
    
    // Method to convert string to mood for moodSlider and also set the moodValue
    func fluidMoodString(string: String, slider: Slider) -> String {
        switch string {
        case "0":
            slider.contentViewColor = DynamicColor(hexString: "#976DD0")
            moodValue = "Excellent"
        case "1":
            slider.contentViewColor = DynamicColor(hexString: "#00A6FF")
            moodValue = "Great"
        case "2":
            slider.contentViewColor = DynamicColor(hexString: "#13CE66")
            moodValue = "Good"
        case "3":
            slider.contentViewColor = DynamicColor(hexString: "#E9F50C")
            moodValue = "Fair"
        case "4":
            slider.contentViewColor = DynamicColor(hexString: "#FFBA5C")
            moodValue = "Down"
        case "5":
            slider.contentViewColor = DynamicColor(hexString: "#F95F62")
            moodValue = "Bad"
        default:
            slider.contentViewColor = DynamicColor(hexString: "#00A6FF")
            moodValue = "Great"
        }
        
        return moodValue
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: text)
        
        return updatedText.count <= 450
    }
}
