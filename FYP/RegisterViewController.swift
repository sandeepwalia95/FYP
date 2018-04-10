//
//  RegisterViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 27/01/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerPressed(_ sender: Any) {
        
        // Validation of required fields
        if (firstNameTextField.text?.isEmpty)! ||
           (lastNameTextField.text?.isEmpty)! ||
           (ageTextField.text?.isEmpty)! ||
           (emailAddressTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! {
          
            // Show Alert message here and return
            displayAlertMessage(alertMessage: "All Fields are Required")
            return
        } else if (!(emailAddressTextField.text?.contains("@"))!) {
            displayAlertMessage(alertMessage: "Not a valid email address \n eg. myname@me.com")
            return
        }
        
        // Validation of password
    if ((passwordTextField.text?.elementsEqual(reEnterPasswordTextField.text!))! != true) {
        
        // Show Alert message here and return
        displayAlertMessage(alertMessage: "Passwords don't match")
        return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(firstNameTextField.text, forKey: "firstNameKey")
        defaults.set(lastNameTextField.text, forKey: "lastNameKey")
        defaults.set(ageTextField.text, forKey: "ageTextFieldKey")
        KeychainWrapper.standard.set(emailAddressTextField.text!, forKey: "emailAddressKey")
        KeychainWrapper.standard.set(passwordTextField.text!, forKey: "passwordKey")
        KeychainWrapper.standard.set(passwordTextField.text!, forKey: "tempPasswordKey")
//        defaults.set(emailAddressTextField.text, forKey: "emailAddressKey")
//        defaults.set(passwordTextField.text, forKey: "passwordKey")
//        defaults.set(passwordTextField.text, forKey: "tempPasswordKey")
        
        defaults.set(true, forKey: "isRegistered")
        
        let email = defaults.string(forKey: "emailAddressKey")
        print(email)
        
        let newEmail = KeychainWrapper.standard.string(forKey: "emailAddressKey")
        print(newEmail)
        let newPassword = KeychainWrapper.standard.string(forKey: "passwordKey")
        print(newPassword)
        let newTemp = KeychainWrapper.standard.string(forKey: "tempPasswordKey")
        print(newTemp)
        
        let registered = defaults.bool(forKey: "isRegistered")
        
        print(registered)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlertMessage(alertMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Something is wrong!", message: alertMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setupViews() {
        createButton.layer.cornerRadius = 7.0
        createButton.clipsToBounds = true
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
