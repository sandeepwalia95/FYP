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

class LogEntryViewController: UIViewController {

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
    
    @IBOutlet weak var sleepSlider: Slider!
    @IBOutlet weak var alcoholSlider: Slider!
    @IBOutlet weak var workSlider: Slider!
    
    var sleepValue = 0
    var alcoholValue = 0
    var workValue = 0
    
    @IBOutlet weak var moodSlider: UISlider!
    //@IBOutlet weak var sleepSlider: UISlider!
    //@IBOutlet weak var alcoholSlider: UISlider!
    //@IBOutlet weak var workSlider: UISlider!
    @IBOutlet weak var medicationSwitch: UISwitch!
    
    var ref: DatabaseReference!
    
    var activityButtons: [UIButton] = []
    var activitiesSelected: [String] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Button UI
        setupActivityButtons()
        
        // Button title
        setActivityButtonTitles()
        
        setFluidSlider(slider: sleepSlider, maxVal: 10, maxLabel: "10+")
        setFluidSlider(slider: alcoholSlider, maxVal: 20, maxLabel: "20+")
        setFluidSlider(slider: workSlider, maxVal: 10, maxLabel: "10+")
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
    
    // Change mood slider and label color and values
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
    
//    // Change sleep slider
//    @IBAction func selectSleep(_ sender: Any) {
//        sleepSlider.value = roundf(sleepSlider.value)
//
//        sleepLabel.text = Int(sleepSlider.value).description + " hrs"
//    }
    
//    // Change alcohol slider
//    @IBAction func selectAlcohol(_ sender: Any) {
//        alcoholSlider.value = roundf(alcoholSlider.value)
//
//        alcoholLabel.text = Int(alcoholSlider.value).description + " units"
//    }
    
    // Display Alcohol information for units
    @IBAction func alcoholInfo(_ sender: Any) {
        displayAlertMessage(alertMessage: "Beer(pint): 2 units \n Spirts(25ml): 1 unit \n Wine(175ml): 2 units")
    }
    
//    // Change work slider
//    @IBAction func selectWork(_ sender: Any) {
//        workSlider.value = roundf(workSlider.value)
//
//        workLabel.text = Int(workSlider.value).description + " hrs"
//    }
    
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
        let logBranch = ref.child("logs")
        logBranch.child(getCurrentDate()).setValue(["mood" : moodLabel.text,
                                                    "sleep" : sleepValue,
                                                    "alcohol" : alcoholValue,
                                                    "work" : workValue,
                                                    "medication" : medValue,
                                                    "activities" : activitiesSelected])
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
    
    func setFluidSlider(slider: Slider, maxVal: CGFloat, maxLabel: String) {
        
        let labelTextAttributes: [NSAttributedStringKey : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * maxVal) as NSNumber) ?? ""
            if slider.accessibilityIdentifier == "sleep" {
                self.sleepValue = Int(string)!
            } else if slider.accessibilityIdentifier == "alcohol" {
                self.alcoholValue = Int(string)!
            } else if slider.accessibilityIdentifier == "work" {
                self.workValue = Int(string)!
            }
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: maxLabel, attributes: labelTextAttributes))
        slider.fraction = 0.5
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor(red: 78/255.0, green: 77/255.0, blue: 224/255.0, alpha: 1)
        slider.valueViewColor = .white
        slider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(slider: slider, true, animated: true)
        }
        slider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(slider: slider, false, animated: true)
        }
    }
    
    private func setLabelHidden(slider: Slider, _ hidden: Bool, animated: Bool) {
        let animations = {
            if slider.accessibilityIdentifier == "sleep" {
                self.sleepLabel.alpha = hidden ? 0 : 1
            } else if slider.accessibilityIdentifier == "alcohol" {
                self.alcoholLabel.alpha = hidden ? 0 : 1
                self.alcoholInfo.alpha = hidden ? 0 : 1
            } else if slider.accessibilityIdentifier == "work" {
                self.workLabel.alpha = hidden ? 0 : 1
            }
        }
        if animated {
            UIView.animate(withDuration: 0.1, animations: animations)
        } else {
            animations()
        }
    }
}
