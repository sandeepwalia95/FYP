//
//  DetailLogViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 16/02/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import DynamicColor

class DetailLogViewController: UIViewController {
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var moodView: UIView!
    
    @IBOutlet weak var sleepProgressView: MBCircularProgressBarView!
    @IBOutlet weak var alcoholProgressView: MBCircularProgressBarView!
    @IBOutlet weak var workProgressView: MBCircularProgressBarView!
    
    var log = Log(date: "", mood: "", sleep: 0, alcohol: 0, work: 0, medication: true, activities: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.moodLabel.text = self.log.mood
        
        let moodColor = moodToColor(mood: self.log.mood)
        self.moodView.backgroundColor = DynamicColor(hexString: moodColor)
        
        self.sleepProgressView.value = 0
        self.alcoholProgressView.value = 0
        self.workProgressView.value = 0
        
        self.sleepProgressView.progressColor = DynamicColor(hexString: moodColor)
        self.alcoholProgressView.progressColor = DynamicColor(hexString: moodColor)
        self.workProgressView.progressColor = DynamicColor(hexString: moodColor)
        
        self.sleepProgressView.progressStrokeColor = DynamicColor(hexString: moodColor)
        self.alcoholProgressView.progressStrokeColor = DynamicColor(hexString: moodColor)
        self.workProgressView.progressStrokeColor = DynamicColor(hexString: moodColor)
        
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
    
    // Method to convert a string to a mood based on mood retrieved from Firebase within snapshot.
    func moodToColor(mood: String) -> String {
        
        let color: String
        switch mood {
        case "Excellent":
            color = "#976DD0"
        case "Great":
            color = "#00A6FF"
        case "Good":
            color = "#13CE66"
        case "Fair":
            color = "#E9F50C"
        case "Uh-Oh":
            color = "#FFBA5C"
        case "Bad":
            color = "#F95F62"
        default:
            color = "#976DD0"
        }
        
        return color
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
