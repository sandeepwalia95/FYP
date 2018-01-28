//
//  RegisterViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 27/01/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit

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
        defaults.set(emailAddressTextField.text, forKey: "emailAddressKey")
        defaults.set(passwordTextField.text, forKey: "passwordKey")
        
        let email = defaults.string(forKey: "emailAddressKey")
        print(email)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlertMessage(alertMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setupViews() {
        firstNameTextField.layer.cornerRadius = 7.0
        firstNameTextField.layer.borderWidth = 1.5
        firstNameTextField.clipsToBounds = true
        
        lastNameTextField.layer.cornerRadius = 7.0
        lastNameTextField.layer.borderWidth = 1.5
        lastNameTextField.clipsToBounds = true
        
        ageTextField.layer.cornerRadius = 7.0
        ageTextField.layer.borderWidth = 1.5
        ageTextField.clipsToBounds = true
        
        emailAddressTextField.layer.cornerRadius = 7.0
        emailAddressTextField.layer.borderWidth = 1.5
        emailAddressTextField.clipsToBounds = true
        
        passwordTextField.layer.cornerRadius = 7.0
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.clipsToBounds = true
        
        reEnterPasswordTextField.layer.cornerRadius = 7.0
        reEnterPasswordTextField.layer.borderWidth = 1.5
        reEnterPasswordTextField.clipsToBounds = true
        
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
