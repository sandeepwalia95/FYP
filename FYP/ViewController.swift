//
//  ViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 27/01/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var conditionLabel: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ref = Database.database().reference()
        
        let conditionRef = ref.child("condition")
        conditionRef.observe(.value) { (snap: DataSnapshot) in
            self.conditionLabel.text = (snap.value as! String).description
            print(snap)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sunnyPressed(_ sender: Any) {
        ref.child("Hilary").childByAutoId().setValue("Sandeep")
    }
    
    @IBAction func foggyPressed(_ sender: Any) {
    }
}

