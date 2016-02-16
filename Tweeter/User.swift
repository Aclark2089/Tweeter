//
//  User.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

// Global User
var _currentUser: User?

// User object key for the logged in user
let currentUserKey = "currentUserKey"

// Global broadcast events for the app
let userDidLoginNotification = "User logged in!"
let userDidLogoutNotification = "User logged out!"

class User: NSObject {
    
    // User properties we need
    var name: String?
    var screenName: String?
    var profileImageURL: String?
    var tagline: String?
    var dictionary: NSDictionary?

    // Profile Images For User
    var profileBackgroundColor: String?
    var profileBackgroundURL: String?
    
    // Tweet Dates
    var createdAtString: String?

    // Follower, Favorites, and Friends Metrics for User
    var favoriteCount: Int?
    var friendsCount: Int?
    var followersCount: Int?
    
    // Initialize the user object
    init(dictionary: NSDictionary){
        
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        favoriteCount = dictionary["favourites_count"] as? Int
        friendsCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        profileBackgroundColor = dictionary["profile_background_color"] as? String
        profileBackgroundURL = dictionary["profile_background_image_url"] as? String

    }
    
    // Function to handle user logging out from Tweeter
    func logout() {
        
        // Set current user to nil, kill access token and clear the saved user key
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // Broadcast the logout event to the application
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
    }
    
    // currentUser class that has the User class and additional methods
    class var currentUser: User? {

        // Get user
        get {
        
            // If we have no current user only, setup the new current user
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        
                // If we have gotten a vavlue for the currentUserKey, then we try to initialize the User properties using the data
                if data != nil {
                    // Try to serialize a dict object using the JSON data we received with the object key
                    do {
                        var dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
                       _currentUser = User(dictionary: dictionary!)
                    } catch let error as NSError { // Serialization Failed, log error
                        NSLog("Error: \(error)")
                    }
                }
            }
        
            // Return the current user
            return _currentUser
        }
        // Set the user
        set(user) {
            
            // If passed user is not nil, set current user
            if user != nil {
                _currentUser = user
                
                // Setup persistence for the set user
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions(rawValue: 0))
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch let error as NSError { // Serialization Failed, log error & we set nothing for the current user
                    NSLog("Error : \(error)")
                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                }
                    
                // Save the NSUserDefaults for access
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        
        }
    }
}
