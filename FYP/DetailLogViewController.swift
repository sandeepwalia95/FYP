//
//  DetailLogViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 16/02/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class DetailLogViewController: UIViewController {
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var sleepProgressView: MBCircularProgressBarView!
    @IBOutlet weak var alcoholProgressView: MBCircularProgressBarView!
    @IBOutlet weak var workProgressView: MBCircularProgressBarView!
    
    var log = Log(date: "", mood: "", sleep: 0, alcohol: 0, work: 0, medication: true, activities: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.moodLabel.text = self.log.mood
        
        self.sleepProgressView.value = 0
        self.alcoholProgressView.value = 0
        self.workProgressView.value = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 1.0) {
            self.sleepProgressView.value = CGFloat(self.log.sleep)
            self.alcoholProgressView.value = CGFloat(self.log.alcohol)
            self.workProgressView.value = CGFloat(self.log.work)
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
