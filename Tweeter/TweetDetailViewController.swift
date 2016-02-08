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
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var tweetContentLabel: UILabel!
    @IBOutlet var retweetCountLabel: UILabel!
    @IBOutlet var favoriteCountLabel: UILabel!
    @IBOutlet var usersRetweetedLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var favoriteImageView: UIImageView!
    @IBOutlet var replyImageView: UIImageView!
    @IBOutlet var retweetImageView: UIImageView!
    @IBOutlet var usersRetweetImageView: UIImageView!

    
    
    // Variables
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
