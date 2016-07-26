//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Dang Quoc Huy on 7/26/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapSend(sender: UIButton) {
        
        guard let message = messageField.text else {
            self.showAlert("text is nil")
            return
        }
        guard !message.isEmpty else {
            self.showAlert("empty message")
            return
        }
        
        let messageObj = PFObject(className: "Message")
        messageObj["text"] = message
        messageObj.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) in
            
            if success {
                // The object has been saved.
                // reset message textbox
                self.messageField.text = nil
            } else {
                // There was a problem, check error.description
                self.showAlert((error?.description)!)
            }
        }
    }
    
    @IBAction func tapDismiss(sender: AnyObject) {

        dismissViewControllerAnimated(true, completion: nil)
    }
}
