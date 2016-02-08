//
//  TweetCell.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    // Outlets
    
    // Images
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var usersRetweetImageView: UIImageView!
    
    // Labels
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tweetContentLabel: UILabel!
    @IBOutlet var favoriteCountLabel: UILabel!
    @IBOutlet var retweetCountLabel: UILabel!
    
    // Buttons
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    
    
    // Variables
    
    // Tweet we are referencing for this cell
    var tweet: Tweet! {
        didSet {
            // Tweet content
            tweetContentLabel.text = tweet.text!
            tweetContentLabel.sizeToFit()
            
            // Users' profile and username
            profileNameLabel.text = tweet.user!.name
            usernameLabel.text = "@\(tweet.user!.screenName!)"

            // Setup count labels
            retweetCountLabel.text = "\(tweet.retweetCount!)"
            favoriteCountLabel.text = "\(tweet.favoriteCount!)"
            
            // User's image
            profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!)!)
            profileImageView.layer.cornerRadius = 5
            profileImageView.clipsToBounds = true;
            
            retweetCount = tweet.retweetCount!
            favoriteCount = tweet.favoriteCount!
            timeLabel.text = "\(tweet.createdAtString!)"
        }
    }
    
    var isRetweet = false
    var isFavorite = false
    var retweetCount: Int!
    var favoriteCount: Int!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        isRetweet = !isRetweet
        
        if (isRetweet) {
            retweetButton.tintColor = UIColor.greenColor()
            retweetCountLabel.textColor = UIColor.greenColor()
            //            if (tweet.retweetCount != nil) {
            //                tweet.retweetCount = tweet.retweetCount! + 1
            //            }
            TwitterClient.sharedInstance.retweetMe(tweet.id!)
        }
    }
    
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        isRetweet = !isFavorite
        
        if (isFavorite) {
            favoriteButton.tintColor = UIColor.redColor()
            favoriteCountLabel.textColor = UIColor.redColor()
            //            if (tweet.user?.favoriteCount != nil) {
            //                tweet.user?.favoriteCount = tweet.user!.favoriteCount! + 1
            //            }
            TwitterClient.sharedInstance.favoriteMe(tweet.id!)
        }
    }

}
