//
//  ChartViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 28/02/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import SwiftChart

class ChartViewController: UIViewController {

    @IBOutlet weak var chart: Chart!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let series = ChartSeries([0, 6.5, 2])
        
        series.area = true
        
        let hours = ["jan", "feb", "mar"]
        //chart.xLabels = [0, 3, 6, 9, 12, 15, 18, 21, 24]
        //chart.xLabelsFormatter = { _,_ in "jan" }
                chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
                    return String(describing: (hours[labelIndex]))
                }
        chart.add(series)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
