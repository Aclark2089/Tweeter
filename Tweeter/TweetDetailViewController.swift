//
//  TweetDetailViewController.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    // Outlets
    
    // User properties
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var tweetContentLabel: UILabel!
    @IBOutlet var retweetCountLabel: UILabel!
    @IBOutlet var favoriteCountLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    // Images for Detail View
    @IBOutlet var profileImageView: UIImageView!
    
    // Buttons
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!

    
    // Variables
    var tweet: Tweet!
    var isRetweet = false
    var isFavorite = false
    var retweetCount: Int!
    var favoriteCount: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup tweet content for this detail view on call
        setTweetContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setTweetContent() {
        // Tweet content
        tweetContentLabel.text = tweet.text!
        tweetContentLabel.sizeToFit()
        
        // Users' profile and username
        profileNameLabel.text = tweet.user!.name!
        usernameLabel.text = "@\(tweet.user!.screenName!)"
        
        // Setup count labels
        retweetCountLabel.text = "\(tweet.retweetCount!) RETWEETS"
        favoriteCountLabel.text = "\(tweet.favoriteCount!) FAVORITES"
        
        // User's image
        profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!)!)
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true;
        
        timeLabel.text = "\(tweet.createdAtString!)"
    }
    
    // Increment the fav or RT counts and their labels
    func labelIncrement(type: String) {
        if (type.lowercaseString == "retweet") {
            // It is a rt
            tweet.retweetCount! = tweet.retweetCount! + 1
            retweetCount = tweet.retweetCount
            retweetCountLabel.text = "\(retweetCount) RETWEETS"
        } else {
            // It is a fav
            tweet.favoriteCount! = tweet.favoriteCount! + 1
            favoriteCount = tweet.favoriteCount!
            favoriteCountLabel.text = "\(favoriteCount) RETWEETS"
        }
    }
    
    
    // Actions
    
    // Call parent reply for this call
    @IBAction func onDetailReply(sender: AnyObject) {
    }
    
    // Call parent retweet for this cell
    @IBAction func onDetailRetweet(sender: AnyObject) {
        if !(tweet.isRetweeted!) {
            
            // Setup the label & button colors
            retweetButton.tintColor = UIColor.greenColor()
            retweetCountLabel.textColor = UIColor.greenColor()
            
            // Change the RT label
            labelIncrement("retweet")
            
            // Send retweet
            TwitterClient.sharedInstance.retweetMe(tweet.id!)
            
        }
    }
    
    // Call parent favorite for this cell
    @IBAction func onDetailFavorite(sender: AnyObject) {
        if !(tweet.isFavorited!) {
            
            // Setup the label & button colors
            favoriteButton.tintColor = UIColor.redColor()
            favoriteCountLabel.textColor = UIColor.redColor()
            
            // Change fav label
            labelIncrement("favorite")
            
            // Send retweet
            TwitterClient.sharedInstance.favoriteMe(tweet.id!)
        }
    

    }
}