//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Dang Quoc Huy on 7/26/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4
import FBSDKCoreKit

class ChatViewController: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = [PFObject]()
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ChatViewController.fetchMessages), userInfo: nil, repeats: true)
        fetchMessages()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if let timer = timer {
            timer.invalidate()
        }
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
        messageObj["user"] = PFUser.currentUser()
        messageObj.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) in
            
            if success {
                // The object has been saved.
                // reset message textbox
                self.messageField.text = nil
                self.fetchMessages()
            } else {
                // There was a problem, check error.description
                self.showAlert((error?.description)!)
            }
        }
    }
    
    @IBAction func tapDismiss(sender: AnyObject) {

        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func fetchMessages() {
        
        let query = PFQuery(className: "Message")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (messages: [PFObject]?, error: NSError?) in
            
            if error == nil {
                if let messages = messages {
                    self.messages = messages
                    self.tableView.reloadData()
                }
            } else {
                print(error?.description)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate {
    
    // Asks the data source for a cell to insert in a particular location of the table view.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
            // try get facebook avatar
            if PFFacebookUtils.isLinkedWithUser(user) {
                
                // Code work with Facebook API here
            }
        }
        
        return cell
    }
}

extension ChatViewController: UITableViewDataSource {
    
    // Tells the data source to return the number of rows in a given section of a table view.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
}
