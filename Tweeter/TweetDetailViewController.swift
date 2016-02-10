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
    @IBOutlet var usersRetweetedLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    // Images for Detail View
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var favoriteImageView: UIImageView!
    @IBOutlet var replyImageView: UIImageView!
    @IBOutlet var retweetImageView: UIImageView!
    @IBOutlet var usersRetweetImageView: UIImageView!

    
    // Variables
    var tweet: Tweet!

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
        retweetCountLabel.text = "\(tweet.retweetCount!)"
        favoriteCountLabel.text = "\(tweet.favoriteCount!)"
        
        // User's image
        profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!)!)
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true;
        
        timeLabel.text = "\(tweet.createdAtString!)"
    }
    

}
