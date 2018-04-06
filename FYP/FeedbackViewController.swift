//
//  FeedbackViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 07/04/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendFeedback(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let emailController = MFMailComposeViewController()
            emailController.mailComposeDelegate = self
            emailController.setToRecipients(["sandeepfyp@gmail.com"])
            emailController.setSubject("Beatha - Feedback")
            
            present(emailController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
