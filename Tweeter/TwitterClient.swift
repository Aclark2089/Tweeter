//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "SwKvrVJkarLigmBdd1rtRn8iD"
let twitterConsumerSecret = "PaCmRn0NB3Ic5ajMyovFJBG4ZmmKoyPM4NYOBFLOZqRMdqe4oQ"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    // Variable for the login completion to hold closure until needed
   
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    
    // Our Singleton Shared Instance
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        // Hit the timeline endpoint
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?)  -> Void in
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            for tweet in tweets{
                print(tweet.user?.name)
            }
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
                print("Couldn't get the home timeline") //  Couldn't get the home timeline
                completion(tweets: nil, error: nil)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Twitter Login
        
        // Request Token Fetch & Redirection to Auth
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got request token!")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            },
            failure: {(error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        })
    }
    
    
    func openURL(url: NSURL) {

        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            
            // Save Our Access Token Now
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            // Verify Our Credentials
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Successfully made the access token post")
                var user = User(dictionary: response as! NSDictionary)
                //print(response) // Optional output for the response object
                print("\(user.name)") // Check if getting correct credentials
                User.currentUser = user // Set our current user
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    //print(error)
                    print("Failure to receive access token") //  We couldn't get the token, check the connection or API auth
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                print("Error: Access Token Authorization") // We make it here and we have problems
                self.loginCompletion?(user: nil, error: error)
        }
    
    }
}
