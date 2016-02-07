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
    @IBOutlet var replyImageView: UIImageView!
    @IBOutlet var retweetImageView: UIImageView!
    @IBOutlet var favoriteImageView: UIImageView!
    @IBOutlet var usersRetweetImageView: UIImageView!
    
    // Labels
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tweetContentLabel: UILabel!
    @IBOutlet var favoriteCountLabel: UILabel!
    @IBOutlet var retweetCountLabel: UILabel!
    
    
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
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
