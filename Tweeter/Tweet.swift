//
//  Tweet.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var dictionary: NSDictionary?
    var favoriteCount: Int?
    var retweetCount: Int?
    var id: String?
    var isFavorited: Bool?
    var isRetweeted: Bool?
    
    init(dictionary: NSDictionary) {
        
        // Set dictionary object
        self.dictionary = dictionary
        
        // Setup the tweet user
        user = User(dictionary: (dictionary["user"] as! NSDictionary))
        
        // Get tweet content
        text = dictionary["text"] as? String
        
        // Setup formatter to handle the date conversion using custom date format
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        // Format date from dictionary and set it to the string and date properties
        createdAtString = dictionary["created_at"] as? String
        createdAt = formatter.dateFromString(createdAtString!)
        formatter.dateStyle = .ShortStyle
        createdAtString = formatter.stringFromDate(createdAt!)
        
        // Set counts
        favoriteCount = dictionary["favorite_count"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        
        // Tweet ID for RT and Fav
        id = dictionary["id_str"] as? String
        
        // Bool for tweet and fav check
        isFavorited = dictionary["favorited"] as? Bool
        isRetweeted = dictionary["retweeted"] as? Bool
        
    }
    
    
    // Return tweets array from the inputted data
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
}
