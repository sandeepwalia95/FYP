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
import AVFoundation
import AudioToolbox

class BreatheViewController: UIViewController {

    @IBOutlet weak var timerSlider: Slider!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var selectMinutesLabel: UILabel!
    var timerValue = 0
    var sliderString = ""
    
    var timer = Timer()
    
    var isRunning: Bool = false
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = startButton.bounds.size.width/2;
        stopButton.layer.cornerRadius = stopButton.bounds.size.width/2;
        pauseButton.layer.cornerRadius = pauseButton.bounds.size.width/2;
        
          let labelTextAttributes: [NSAttributedStringKey : Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: UIColor.white]
        timerSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 4) + 1 as NSNumber) ?? ""
            
            self.sliderString = string
            
            self.timerValue = self.minutesToSeconds(minute: Int(self.sliderString)!)
            
            self.secondsLabel.text = String(self.timerValue) + " seconds"
            
            return NSAttributedString(string: string)
        }
        
        timerSlider.setMinimumLabelAttributedText(NSAttributedString(string: "1", attributes: labelTextAttributes))
        timerSlider.setMaximumLabelAttributedText(NSAttributedString(string: "5", attributes: labelTextAttributes))
        timerSlider.fraction = 0.5
        timerSlider.shadowOffset = CGSize(width: 0, height: 10)
        timerSlider.shadowBlur = 5
        timerSlider.shadowColor = UIColor(white: 0, alpha: 0.1)
        timerSlider.contentViewColor = DynamicColor(hexString: "#85C1E9")
        timerSlider.valueViewColor = .white
        timerSlider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        timerSlider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
        }
        
        do {
            let audioPath = Bundle.main.path(forResource: "5 - Minute", ofType: ".mp3")
            
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
        } catch {
            // Error
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        player.play()
        
        startButton.isEnabled = false
        selectMinutesLabel.isHidden = true
        timerSlider.isHidden = true
    }
    
    @IBAction func stop(_ sender: Any) {
        timer.invalidate()
        player.stop()
        player.currentTime = 0
        
        self.timerValue = self.minutesToSeconds(minute: Int(self.sliderString)!)
        
        self.secondsLabel.text = String(self.timerValue) + " seconds"
        
        startButton.isEnabled = true
        selectMinutesLabel.isHidden = false
        timerSlider.isHidden = false
    }
    
    @IBAction func pause(_ sender: Any) {
        timer.invalidate()
        player.pause()
        
        startButton.isEnabled = true
    }
    
    @objc func action() {
        
        if timerValue % 5 == 0 {
            AudioServicesPlaySystemSound(1519)
        }
        
        timerValue -= 1
        self.secondsLabel.text = String(self.timerValue) + " seconds"
        
        
        if timerValue == 0 {
            timer.invalidate()
            player.stop()
            
            startButton.isEnabled = true
            selectMinutesLabel.isHidden = false
            timerSlider.isHidden = false
        }
    }
    
    func minutesToSeconds(minute: Int) -> Int {
        return minute * 60
    }
    
    private func setLabelHidden(_ hidden: Bool, animated: Bool) {
        let animations = {
            self.selectMinutesLabel.alpha = hidden ? 0 : 1
        }
        if animated {
            UIView.animate(withDuration: 0.11, animations: animations)
        } else {
            animations()
        }
    }

}
