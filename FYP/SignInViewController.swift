//
//  SignInViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 27/01/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordTextField.layer.cornerRadius = 7.0
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.clipsToBounds = true
        
        emailAddressTextField.layer.cornerRadius = 7.0
        emailAddressTextField.layer.borderWidth = 1.5
        emailAddressTextField.clipsToBounds = true
        
        signInButton.layer.cornerRadius = 7.0
        signInButton.clipsToBounds = true
        print("Gotcha")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInPressed(_ sender: Any) {
        print("Sign In Pressed")

        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "emailAddressKey")
        print(email)
        
        if email != nil {
            if (emailAddressTextField.text?.isEqual(email))! {
                print("Success")
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        print("Register Pressed")
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.present(registerViewController, animated: true)
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
