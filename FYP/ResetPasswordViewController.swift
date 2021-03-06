//
//  ResetPasswordViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 21/03/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var resetPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func resetPassword(_ sender: Any) {
        if (resetPasswordTextField.text?.isEmpty)! {
            displayAlertMessage(title: "Oops!", alertMessage: "No password entered")
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(resetPasswordTextField.text, forKey: "passwordKey")
        defaults.set(resetPasswordTextField.text, forKey: "tempPasswordKey")
        resetPasswordTextField.text = ""
        
        displayAlertMessage(title: "Success!", alertMessage: "Password has been reset")
    }
    
    func displayAlertMessage(title: String ,alertMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
