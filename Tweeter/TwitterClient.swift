//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

// Twitter Keys
let twitterConsumerKey = "SwKvrVJkarLigmBdd1rtRn8iD"
let twitterConsumerSecret = "PaCmRn0NB3Ic5ajMyovFJBG4ZmmKoyPM4NYOBFLOZqRMdqe4oQ"
let twitterBaseURL = NSURL(string: "https://api.twitter.com/")

class TwitterClient: BDBOAuth1SessionManager {
    
    // Variable for the login completion to hold closure until needed
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    
    // Our Singleton Shared Instance
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        // Get static TwitterClient instance of the keys
        return Static.instance
    }
    
    // Get our home timeline
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        // Get the timeline data for current user
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?)  -> Void in
                // Set our tweets for the response from the Get function
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                // Log tweet usernames
                for tweet in tweets {
                    NSLog("\(tweet.user?.name)")
                }
                // Completion made with the tweets array and no errors passed since we succeeded
                completion(tweets: tweets, error: nil)
                },
                // We failed to get the response object, log the error
                failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    NSLog("Couldn't get the home timeline\nError: \(error)")
                    NSLog("")
                    // Completion gets nothing
                    completion(tweets: nil, error: nil)
            })
    }
    
    // Retweet the tweet for the passed id
    func retweet(id: String) {
        POST("https://api.twitter.com/1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            NSLog("Successfully retweeted")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                NSLog("Failed to retweet\nError: \(error)")
        }
    }
    
    // Cancel previous retweet made on this tweet of passed id
    func unRetweet(id: String) {
        POST("https://api.twitter.com/1.1/statuses/unretweet/\(id).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully removed retweet on tweet")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to remove retweet\nError: \(error)")
        }
    }

    // Favorite the tweet for the passed id
    func favorite(id: String) {
        POST("https://api.twitter.com/1.1/favorites/create.json?id=\(id)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Succesfully favorited")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to favorite")
        }
    }
    
    // Cancel previous favorite made on this tweet of passed id
    func unFavorite(id: String) {
        POST("https://api.twitter.com/1.1/favorites/destroy.json?id=\(id)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Succesfully removed favorite on tweet")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to remove favorite\nError: \(error)")
        }
    }
    
    // Login the User using completion we have been passed
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {

        // Set local completion
        loginCompletion = completion
        
        // Request Token Fetch & Redirection to Auth
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken() // Kill current access token and get a new one if we are logging in
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            NSLog("Got request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            },
            // Failure to get request token, log error
            failure: {(error: NSError!) -> Void in
                NSLog("Failed to get request token\nError: \(error)")
                // Finish completion with nil user and error
                self.loginCompletion?(user: nil, error: error)
        })
    }
    
    
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            // Log success
            NSLog("Got access token")
            
            // Save Our Access Token
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            // Verify Our Credentials
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                NSLog("Successfully made the access token post")
                
                // Set user using the response
                var user = User(dictionary: response as! NSDictionary)
                
                // Log list of tweet usersnames to check if getting correct credentials
                NSLog("\(user.name)")
                
                // Set our current user
                User.currentUser = user
                self.loginCompletion?(user: user, error: nil)
                },
                // Failure, log error and send nothing for user to completion
                failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    NSLog("Failure to receive access token\n\(error)")
                    self.loginCompletion?(user: nil, error: error)
                }
            )
            
        })
            // Auth failed, we have problems with the authorization using the request token / current connection
            { (error: NSError!) -> Void in
                NSLog("Error: Access Token Authorization\n\(error)")
                self.loginCompletion?(user: nil, error: error)
            }
    
    }
}
