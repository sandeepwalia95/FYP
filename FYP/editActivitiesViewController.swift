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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func edit(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if let text = edit1.text, !text.isEmpty {
                //do something if it's not empty
                defaults.set(text, forKey: "actOne")
                edit1.text = ""
                edit1.placeholder = defaults.string(forKey: "actOne")
            }
        default:
            print("Didnt Work")
        }
    }
    //defaults.set("gav", forKey: "actOne")
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
