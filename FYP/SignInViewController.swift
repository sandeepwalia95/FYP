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
            
            // Email and password required to sign in
            if (emailAddressTextField.text?.isEmpty)! ||
                (passwordTextField.text?.isEmpty)! {
                displayAlertMessage(title: "Oops!", alertMessage: "All fields are required")
            }
            
            // Sign in if details are correct
            if (emailAddressTextField.text?.isEqual(email))! && (passwordTextField.text?.isEqual(password))! {
                print("We did it baby!!")
                
                let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "Tab") as! UITabBarController
                
                self.present(tabViewController, animated: true)
            } else if (!(emailAddressTextField.text?.contains("@"))!) {
                displayAlertMessage(title: "Not a valid email address", alertMessage: "Use an email address with correct format \n eg. myname@me.com")
            } else {
                displayAlertMessage(title: "Oops!", alertMessage: "The email or password is incorrect")
            }
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        print("forgotPasswordPressed")
        
        let userEmailAddress = defaults.string(forKey: "emailAddressKey")!
        let userFirstName = defaults.string(forKey: "firstNameKey")!
        print(userEmailAddress)
        print(userFirstName)
        
        // generate a random string of letters for temporary password
        let passString = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let tempPassword = String((0..<8).map{ _ in passString[Int(arc4random_uniform(UInt32(passString.count)))]})
        print(tempPassword)
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "sandeepfyp@gmail.com"
        smtpSession.password = "sandeepfyp11"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "Sandeep", mailbox: userEmailAddress)]
        builder.header.from = MCOAddress(displayName: "FYP", mailbox: "sandeepfyp@gmail.com")
        builder.header.subject = "Test Email"
        builder.htmlBody="<html><body><div><p><h1>Hi \(userFirstName), Forgot your password?</h1></p><p>Temporary password: \(tempPassword)</p><p>We suggest you change your password immediatley from within the app after logging in.</p><p>Thank You.</p></div></body></html>"

        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
                self.displayAlertMessage(title: "Password reset", alertMessage: "An email has been sent to you on how to reset your password.")
            }
        }
    }
    
    func setupViews() {
        // User will be registered at thios moment so display email address already.
        emailAddressTextField.text = defaults.string(forKey: "emailAddressKey")
        
        signInButton.layer.cornerRadius = 7.0
        signInButton.clipsToBounds = true
    }
    
    func displayAlertMessage(title: String ,alertMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
