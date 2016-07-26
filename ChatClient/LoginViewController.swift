//
//  LoginViewController.swift
//  ChatClient
//
//  Created by Dang Quoc Huy on 7/26/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func tapLogin(sender: UIButton) {
        
        guard let username = usernameField.text,
            let password = passwordField.text else {
                print("nil objects")
                return
        }
        
        guard !username.isEmpty &&
            !password.isEmpty else {
                showAlert("Empty username/password")
                return
        }
        
        PFUser.logInWithUsernameInBackground(username, password: password) {
            (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
                self.showAlert("login failed")
            }
        }
    }

    @IBAction func tapSignUp(sender: UIButton) {
        
        guard let username = usernameField.text,
            let password = passwordField.text else {
                print("nil objects")
                return
        }
        
        guard !username.isEmpty &&
            !password.isEmpty else {
                showAlert("Empty username/password")
                return
        }
        
        let user = PFUser()
        user.username = username
        user.password = password
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                self.showAlert((errorString?.description)!)
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
        }
    }
}
