//
//  NeedSupportViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 06/04/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit

class NeedSupportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeCall(_ sender: Any) {
        
        let url: NSURL = URL(string: "TEL://116123")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
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
