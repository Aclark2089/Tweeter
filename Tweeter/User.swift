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
let currentUserKey = "currentUserKey"
let userDidLoginNotification = "User logged in!"
let userDidLogoutNotification = "User logged out!"

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageURL: String?
    var tagline: String?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // Broadcast the logout event to the application
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do{
                        var dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
                       _currentUser = User(dictionary: dictionary!)
                    } catch let error as NSError {
                        //handle error
                        print("Error : \(error)")
                    }
                }
            }
            return _currentUser
        }
        set(user) {
            if user != nil {
            _currentUser = user
            
            // Setup persistence for the set user
            do{
                let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions(rawValue: 0))
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } catch let error as NSError {
                //handle error
                print("Error : \(error)")
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        }
    }
}
