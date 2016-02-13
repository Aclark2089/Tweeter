//
//  TimelineViewController.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call TC constructor using the key values
        TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Login action
    @IBAction func onLogin(sender: AnyObject) {
        
        // Attempt to login
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            // Only proceed if the login was a success
            if user != nil {
                // Segue from login to our timeline
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
            else { // Login Failure
                NSLog("Error for Login: \(error)")
            }
        }
        
    }

}
