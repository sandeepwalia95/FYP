//
//  LogEntryViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 31/01/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import DynamicColor

class LogEntryViewController: UIViewController {

    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var moodSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button1.layer.cornerRadius = button1.bounds.size.width/2;
        button2.layer.cornerRadius = button2.bounds.size.width/2;
        button3.layer.cornerRadius = button3.bounds.size.width/2;
        button4.layer.cornerRadius = button4.bounds.size.width/2;
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
        case 2:
            moodLabel.text = "Great"
            moodLabel.backgroundColor = DynamicColor(hexString: "#00A6FF")
        case 3:
            moodLabel.text = "Good"
            moodLabel.backgroundColor = DynamicColor(hexString: "#13CE66")
        case 4:
            moodLabel.text = "Fair"
            moodLabel.backgroundColor = DynamicColor(hexString: "#E9F50C")
        case 5:
            moodLabel.text = "Uh-Oh"
            moodLabel.backgroundColor = DynamicColor(hexString: "#FFBA5C")
        case 6:
            moodLabel.text = "Bad"
            moodLabel.backgroundColor = DynamicColor(hexString: "#F95F62")
        default:
            moodLabel.text = "Great"
            moodLabel.backgroundColor = DynamicColor(hexString: "#00A6FF")
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
