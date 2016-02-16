//
//  NewTweetViewController.swift
//  Tweeter
//
//  Created by Alex Clark on 2/15/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet var goButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var tweetTextField: UITextField!
    @IBOutlet var charLeftLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onTweetEntered(sender: AnyObject) {
        
        // Store temporary tweet text and count of the tweet characters
        let tempTweet = tweetTextField.text
        let counter = tempTweet?.characters.count
        
        // Check the changed label for how many characters have been entered
        charLeftLabel.text = "\(140 - counter!)"
        
        // Countdown characters
        
        // Change color on low characters remaining
        if (Int(charLeftLabel.text!)! <= 15) {
            charLeftLabel.textColor = UIColor.redColor();
        } else {
            charLeftLabel.textColor = UIColor.whiteColor();
        }
        
        // Stop going past the 140 count
        if (Int(charLeftLabel.text!)! <= 0) {
            tweetTextField.text = String(tweetTextField.text!.characters.dropLast())
        }
        
    }
    
    
    
    @IBAction func onCancel(sender: AnyObject) {
        
        // Get rid of current view
         dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    @IBAction func onGo(sender: AnyObject) {
        
        // If there is text within the text field
        if (tweetTextField.text != nil) {
            
            // Check tweet we are sending
            let tweetContent = tweetTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            // Send this tweet
            TwitterClient.sharedInstance.sendTweet(tweetContent)
        }
        
        // Get rid of our current view
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
