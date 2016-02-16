//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Alex Clark on 2/15/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // User for this profile
    var user: User?
    var tweet: Tweet!
    var currentUserProfile = true

    // Profile Image and Background
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileImageBackgroundView: UIImageView!
    
    // Friends, Favorites, and Follow Counts
    @IBOutlet var favoriteCountLabel: UILabel!
    @IBOutlet var friendCountLabel: UILabel!
    @IBOutlet var followerCountLabel: UILabel!
    
    // Name, Tag Line, and Handle
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var tagLineLabel: UILabel!
    @IBOutlet var screenNameLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (currentUserProfile) {
            TwitterClient.sharedInstance.myCredentials() { (user, error) -> () in
                
                // Set user as ourselves
                self.user = user
                
                // Now we need to set all our own content for this profile timeline
                self.profileImageView.setImageWithURL(NSURL(string: user.profileImageURL!)!)
                
                // Round and clip the image so it fits
                self.profileImageView.layer.cornerRadius = 30;
                self.profileImageView.clipsToBounds = true
                
                
                // Set names for users
                self.userNameLabel.text = "\(user.name!)"
                self.screenNameLabel.text = "\(user.screenName!)"
                
                // Set tag
                self.tagLineLabel.text = "\(user.tagline!)"
                
                
                // Counts of their followers, the people they follow, and their favorited tweets
                self.favoriteCountLabel.text = "\(user.favoriteCount!)"
                self.friendCountLabel.text = "\(user.friendsCount!)"
                self.followerCountLabel.text = "\(user.followersCount!)"
                
                // Set user background image
                self.profileImageBackgroundView.setImageWithURL(NSURL(string: user.profileBackgroundURL!)!)
                
            }
        
        }
        else {
            
            // User is not the current user, just used passed tweet user for information
            self.profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL!)!)!)
            
            // Round and clip
            self.profileImageView.layer.cornerRadius = 30;
            self.profileImageView.clipsToBounds = true
            
            // We have to set the name and screen name for the passed user
            self.userNameLabel.text = "\(tweet.user!.name!)"
            self.screenNameLabel.text = "@\(tweet.user!.screenName!)"
            
            // Set tag
            self.tagLineLabel.text = "\(tweet.user!.tagline!)"
            
            // Set counts for the follows, friends, ect.
            self.favoriteCountLabel.text = "\(tweet.user!.favoriteCount!)"
            self.friendCountLabel.text = "\(tweet.user!.friendsCount!)"
            self.followerCountLabel.text = "\(tweet.user!.followersCount!)"
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
