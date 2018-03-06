//
//  editActivitiesViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 06/03/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit

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
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
