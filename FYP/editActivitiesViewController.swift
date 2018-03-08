//
//  editActivitiesViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 06/03/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import DynamicColor

class editActivitiesViewController: UIViewController {

    @IBOutlet weak var edit1: MaxLengthTextField!
    @IBOutlet weak var edit2: MaxLengthTextField!
    @IBOutlet weak var edit3: MaxLengthTextField!
    @IBOutlet weak var edit4: MaxLengthTextField!
    @IBOutlet weak var edit5: MaxLengthTextField!
    @IBOutlet weak var edit6: MaxLengthTextField!
    @IBOutlet weak var edit7: MaxLengthTextField!
    @IBOutlet weak var edit8: MaxLengthTextField!
    @IBOutlet weak var edit9: MaxLengthTextField!
    @IBOutlet weak var edit10: MaxLengthTextField!
    @IBOutlet weak var edit11: MaxLengthTextField!
    @IBOutlet weak var edit12: MaxLengthTextField!
    
    @IBOutlet weak var editButton1: UIButton!
    @IBOutlet weak var editButton2: UIButton!
    @IBOutlet weak var editButton3: UIButton!
    @IBOutlet weak var editButton4: UIButton!
    @IBOutlet weak var editButton5: UIButton!
    @IBOutlet weak var editButton6: UIButton!
    @IBOutlet weak var editButton7: UIButton!
    @IBOutlet weak var editButton8: UIButton!
    @IBOutlet weak var editButton9: UIButton!
    @IBOutlet weak var editButton10: UIButton!
    @IBOutlet weak var editButton11: UIButton!
    @IBOutlet weak var editButton12: UIButton!
    
    var editTextFields = [MaxLengthTextField]()
    var editButtons = [UIButton]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Change activity in userDefaults based on edit button pressed
    @IBAction func edit(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if let text = edit1.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actOne")
                edit1.text = ""
                edit1.placeholder = defaults.string(forKey: "actOne")
            }
        case 2:
            if let text = edit2.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actTwo")
                edit2.text = ""
                edit2.placeholder = defaults.string(forKey: "actTwo")
            }
        case 3:
            if let text = edit3.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actThree")
                edit3.text = ""
                edit3.placeholder = defaults.string(forKey: "actThree")
            }
        case 4:
            if let text = edit4.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actFour")
                edit4.text = ""
                edit4.placeholder = defaults.string(forKey: "actFour")
            }
        case 5:
            if let text = edit5.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actFive")
                edit5.text = ""
                edit5.placeholder = defaults.string(forKey: "actFive")
            }
        case 6:
            if let text = edit6.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actSix")
                edit6.text = ""
                edit6.placeholder = defaults.string(forKey: "actSix")
            }
        case 7:
            if let text = edit7.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actSeven")
                edit7.text = ""
                edit7.placeholder = defaults.string(forKey: "actSeven")
            }
        case 8:
            if let text = edit8.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actEight")
                edit8.text = ""
                edit8.placeholder = defaults.string(forKey: "actEight")
            }
        case 9:
            if let text = edit9.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actNine")
                edit9.text = ""
                edit9.placeholder = defaults.string(forKey: "actNine")
            }
        case 10:
            if let text = edit10.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actTen")
                edit10.text = ""
                edit10.placeholder = defaults.string(forKey: "actTen")
            }
        case 11:
            if let text = edit11.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actEleven")
                edit11.text = ""
                edit11.placeholder = defaults.string(forKey: "actEleven")
            }
        case 12:
            if let text = edit12.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actTwelve")
                edit12.text = ""
                edit12.placeholder = defaults.string(forKey: "actTwelve")
            }
        default:
            print("Didnt Work")
        }
    }
    
    func setupView() {
        
        // textfields
        editTextFields.append(edit1)
        editTextFields.append(edit2)
        editTextFields.append(edit3)
        editTextFields.append(edit4)
        editTextFields.append(edit5)
        editTextFields.append(edit6)
        editTextFields.append(edit7)
        editTextFields.append(edit8)
        editTextFields.append(edit9)
        editTextFields.append(edit10)
        editTextFields.append(edit11)
        editTextFields.append(edit12)
        
        for textField in editTextFields {
            textField.layer.cornerRadius = 7.0
            textField.layer.borderWidth = 3
            textField.layer.borderColor = (DynamicColor(hexString: "#85C1E9")).cgColor
            textField.clipsToBounds = true
        }
        
        // buttons
        editButtons.append(editButton1)
        editButtons.append(editButton2)
        editButtons.append(editButton3)
        editButtons.append(editButton4)
        editButtons.append(editButton5)
        editButtons.append(editButton6)
        editButtons.append(editButton7)
        editButtons.append(editButton8)
        editButtons.append(editButton9)
        editButtons.append(editButton10)
        editButtons.append(editButton11)
        editButtons.append(editButton12)
        
        for button in editButtons {
            button.layer.cornerRadius = 8
        }
        
        edit1.placeholder = defaults.string(forKey: "actOne")
        edit2.placeholder = defaults.string(forKey: "actTwo")
        edit3.placeholder = defaults.string(forKey: "actThree")
        edit4.placeholder = defaults.string(forKey: "actFour")
        edit5.placeholder = defaults.string(forKey: "actFive")
        edit6.placeholder = defaults.string(forKey: "actSix")
        edit7.placeholder = defaults.string(forKey: "actSeven")
        edit8.placeholder = defaults.string(forKey: "actEight")
        edit9.placeholder = defaults.string(forKey: "actNine")
        edit10.placeholder = defaults.string(forKey: "actTen")
        edit11.placeholder = defaults.string(forKey: "actEleven")
        edit12.placeholder = defaults.string(forKey: "actTwelve")
    }
}
