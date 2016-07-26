//
//  SettingsViewController.swift
//  ChatClient
//
//  Created by Dang Quoc Huy on 7/26/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var linkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if PFFacebookUtils.isLinkedWithUser(PFUser.currentUser()!) {
            linkButton.setTitle("Unlink Facebook Account", forState: UIControlState.Normal)
        } else {
            linkButton.setTitle("Link Facebook Account", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func tapButton(sender: UIButton) {
        
        if sender.titleLabel?.text == "Link Facebook Account" {
            PFFacebookUtils.linkUserInBackground(PFUser.currentUser()!, withReadPermissions: nil, block: {
                (succeeded: Bool, error: NSError?) in
                
                if let error = error {
                    self.showAlert(error.description)
                    return
                }
                
                if succeeded {
                    self.showAlert("Woohoo, the user is linked with Facebook!")
                    sender.setTitle("Unlink Facebook Account", forState: UIControlState.Normal)
                }
                
            })
        } else if sender.titleLabel?.text == "Unlink Facebook Account" {
            PFFacebookUtils.unlinkUserInBackground(PFUser.currentUser()!, block: {
                (succeeded: Bool, error: NSError?) -> Void in
                
                if let error = error {
                    self.showAlert(error.description)
                    return
                }
                
                if succeeded {
                    self.showAlert("The user is no longer associated with their Facebook account.")
                    sender.setTitle("Link Facebook Account", forState: UIControlState.Normal)
                }
            })
        }
    }
}
