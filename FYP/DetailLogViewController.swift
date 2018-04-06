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
    @IBOutlet weak var medImageView: UIImageView!
    
    @IBOutlet weak var activityOne: UILabel!
    @IBOutlet weak var activityTwo: UILabel!
    @IBOutlet weak var activityThree: UILabel!
    @IBOutlet weak var activityFour: UILabel!
    @IBOutlet weak var activityFive: UILabel!
    @IBOutlet weak var activitySix: UILabel!
    @IBOutlet weak var activitySeven: UILabel!
    @IBOutlet weak var activityEight: UILabel!
    @IBOutlet weak var activityNine: UILabel!
    @IBOutlet weak var activityTen: UILabel!
    @IBOutlet weak var activityEleven: UILabel!
    @IBOutlet weak var acvtivityTweleve: UILabel!
    
    @IBOutlet weak var sleepProgressView: MBCircularProgressBarView!
    @IBOutlet weak var alcoholProgressView: MBCircularProgressBarView!
    @IBOutlet weak var workProgressView: MBCircularProgressBarView!
    
    var log = Log(date: "", mood: "", sleep: 0, alcohol: 0, work: 0, medication: true, activities: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = log.date
        
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
        
        if self.log.medication == true {
            self.medImageView.image = UIImage(named: "yesMeds.png")!
        } else {
            self.medImageView.image = UIImage(named: "noMeds.png")!
        }
        
        switch log.activities.count {
        case 1:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = " "
            self.activityThree.text = " "
            self.activityFour.text = " "
            self.activityFive.text = " "
            self.activitySix.text = " "
            self.activitySeven.text = " "
            self.activityEight.text = " "
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 2:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = " "
            self.activityFour.text = " "
            self.activityFive.text = " "
            self.activitySix.text = " "
            self.activitySeven.text = " "
            self.activityEight.text = " "
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 3:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = " "
            self.activityFive.text = " "
            self.activitySix.text = " "
            self.activitySeven.text = " "
            self.activityEight.text = " "
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 4:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = " "
            self.activitySix.text = " "
            self.activitySeven.text = " "
            self.activityEight.text = " "
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 5:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = log.activities[4]
            self.activitySix.text = " "
            self.activitySeven.text = " "
            self.activityEight.text = " "
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 6:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = log.activities[4]
            self.activitySix.text = log.activities[5]
            self.activitySeven.text = " "
            self.activityEight.text = " "
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 7:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = log.activities[4]
            self.activitySix.text = log.activities[5]
            self.activitySeven.text = log.activities[6]
            self.activityEight.text = " "
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 8:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = log.activities[4]
            self.activitySix.text = log.activities[5]
            self.activitySeven.text = log.activities[6]
            self.activityEight.text = log.activities[7]
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 9:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = log.activities[4]
            self.activitySix.text = log.activities[5]
            self.activitySeven.text = log.activities[6]
            self.activityEight.text = log.activities[7]
            self.activityNine.text = log.activities[8]
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 10:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = log.activities[4]
            self.activitySix.text = log.activities[5]
            self.activitySeven.text = log.activities[6]
            self.activityEight.text = log.activities[7]
            self.activityNine.text = log.activities[8]
            self.activityTen.text = log.activities[9]
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        case 11:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = log.activities[4]
            self.activitySix.text = log.activities[5]
            self.activitySeven.text = log.activities[6]
            self.activityEight.text = log.activities[7]
            self.activityNine.text = log.activities[8]
            self.activityTen.text = log.activities[9]
            self.activityEleven.text = log.activities[10]
            self.acvtivityTweleve.text = " "
        case 12:
            self.activityOne.text = log.activities[0]
            self.activityTwo.text = log.activities[1]
            self.activityThree.text = log.activities[2]
            self.activityFour.text = log.activities[3]
            self.activityFive.text = log.activities[4]
            self.activitySix.text = log.activities[5]
            self.activitySeven.text = log.activities[6]
            self.activityEight.text = log.activities[7]
            self.activityNine.text = log.activities[8]
            self.activityTen.text = log.activities[9]
            self.activityEleven.text = log.activities[10]
            self.acvtivityTweleve.text = log.activities[11]
        default:
            self.activityOne.text = " "
            self.activityTwo.text = " "
            self.activityThree.text = " "
            self.activityFour.text = " "
            self.activityFive.text = " "
            self.activitySix.text = " "
            self.activitySeven.text = " "
            self.activityEight.text = " "
            self.activityNine.text = " "
            self.activityTen.text = " "
            self.activityEleven.text = " "
            self.acvtivityTweleve.text = " "
        }
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
        case "Down":
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
