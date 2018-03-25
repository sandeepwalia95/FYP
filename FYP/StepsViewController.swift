//
//  StepsViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 25/03/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import HealthKit

class StepsViewController: UIViewController {
    
    let healthStore = HKHealthStore()
    
    var allSteps = [HKQuantitySample]()
    
    var stepDict: [String : Double] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.checkAvailability()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAvailability() -> Bool {
        
        var isAvailable = true
        
        // Is HealthKit data available on this type of device?
        if HKHealthStore.isHealthDataAvailable() {
            
            print("HealthKit data available")
            
            let stepCounter = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount))
            
            healthStore.requestAuthorization(toShare: nil, read: stepCounter as? Set<HKObjectType>, completion: { (success, error) in
                
                isAvailable = success
            })
            
            print("Authorization has been granted")
            
        } else {
            isAvailable = false
            print("HealthKit data is not available")
        }

        return isAvailable
    }
    
    func getSteps(completion: @escaping (Double, NSError?) -> () ) {
        
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        //let lastMonth = NSCalendar.current.date(byAdding: .calendar, value: -30, to: NSDate() as Date)
        
        let calendar = Calendar.current
        let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: twoDaysAgo, end: Date(), options: [])
        
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { (query, results, error) in
            
            var steps: Double = 0
            
            if results!.count > 0 {
//                for result in results as! [HKQuantitySample] {
//                    steps += result.quantity.doubleValue(for: HKUnit.count())
//                    self.allSteps.append(result.quantity.doubleValue(for: HKUnit.count()))
//                }
                self.allSteps = results as! [HKQuantitySample]
                for step in self.allSteps {
                    print(step.startDate)
                    print(step.quantity.doubleValue(for: HKUnit.count()))
                    print("-----------")
                    
                    let date = self.justDate(date: step.startDate)
                    if self.stepDict[date] == nil {
                        self.stepDict[date] = step.quantity.doubleValue(for: HKUnit.count())
                    } else {
                        let amount = step.quantity.doubleValue(for: HKUnit.count())
                        let already = self.stepDict[date]
                        self.stepDict[date] = amount + already!
                    }
                    
                    
                }
                dump(self.stepDict)
            }
            
            completion(steps, error as? NSError)
        }
        healthStore.execute(query)
    }
    
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func getStepCount(_ sender: Any) {
        
        print("OI OI")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        var scount: Double = 0
        getSteps { (steps, error) in
            scount = steps
            print("Scount  \(scount)")
            
            self.stepCountLabel.text = String(scount)
        }
    }
    
    // Return the the current date in the format below
    // *** TODO: Change the format of how the date is presented
    func justDate(date: Date) -> String {
        let newDate = String(describing: date)
        return String(newDate.prefix(10))
    }
    
}
