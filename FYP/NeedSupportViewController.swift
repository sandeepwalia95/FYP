//
//  NeedSupportViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 06/04/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import MessageUI

class NeedSupportViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        callButton.layer.cornerRadius = 7.0
        callButton.clipsToBounds = true
        
        emailButton.layer.cornerRadius = 7.0
        emailButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeCall(_ sender: Any) {
        
        let url: NSURL = URL(string: "TEL://116123")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
            let emailController = MFMailComposeViewController()
            emailController.mailComposeDelegate = self
            emailController.setToRecipients(["jo@samaritans.org"])
            emailController.setSubject("Hello")
           
            present(emailController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
