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
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let isRegistered = defaults.bool(forKey: "isRegistered")
        
        print("HELOOOO", isRegistered)
        
        if isRegistered == false {
            
            let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            
            self.present(registerViewController, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInPressed(_ sender: Any) {
        print("Sign In Pressed")

        let email = defaults.string(forKey: "emailAddressKey")
        
        let password = defaults.string(forKey: "passwordKey")
        
        if email != nil && password != nil {
            if (emailAddressTextField.text?.isEqual(email))! && (passwordTextField.text?.isEqual(password))! {
                print("We did it baby!!")
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        print("Register Pressed")
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.present(registerViewController, animated: true)
    }
    
    func setupViews() {
        passwordTextField.layer.cornerRadius = 7.0
        passwordTextField.layer.borderWidth = 3
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.clipsToBounds = true
        
        emailAddressTextField.layer.cornerRadius = 7.0
        emailAddressTextField.layer.borderWidth = 3
        emailAddressTextField.layer.borderColor = UIColor.white.cgColor
        emailAddressTextField.clipsToBounds = true
        
        signInButton.layer.cornerRadius = 7.0
        signInButton.clipsToBounds = true
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
