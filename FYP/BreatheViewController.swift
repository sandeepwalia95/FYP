//
//  BreatheViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 30/03/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import fluid_slider
import DynamicColor

class BreatheViewController: UIViewController {

    @IBOutlet weak var timerSlider: Slider!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var timerValue = 0
    var sliderString = ""
    
    var timer = Timer()
    
    var isRunning: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 5) as NSNumber) ?? ""
            
            self.sliderString = string
            
            self.timerValue = self.minutesToSeconds(minute: Int(self.sliderString)!)
            
            self.secondsLabel.text = String(self.timerValue)
            
            return NSAttributedString(string: string)
        }
        
        timerSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0"))
        timerSlider.setMaximumLabelAttributedText(NSAttributedString(string: "5"))
        timerSlider.fraction = 0.5
        timerSlider.shadowOffset = CGSize(width: 0, height: 10)
        timerSlider.shadowBlur = 5
        timerSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        timerSlider.contentViewColor = DynamicColor(hexString: "#85C1E9")
        timerSlider.valueViewColor = .white

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
    }
    
    @IBAction func stop(_ sender: Any) {
        timer.invalidate()
        
        self.timerValue = self.minutesToSeconds(minute: Int(self.sliderString)!)
        
        self.secondsLabel.text = String(self.timerValue)
    }
    
    @IBAction func pause(_ sender: Any) {
        timer.invalidate()
    }
    
    @objc func action() {
        timerValue -= 1
        self.secondsLabel.text = String(self.timerValue)
        
        if timerValue == 0 {
            timer.invalidate()
        }
    }
    
    func minutesToSeconds(minute: Int) -> Int {
        return minute * 60
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
