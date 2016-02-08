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
        self.dictionary = dictionary
        user = User(dictionary: (dictionary["user"] as! NSDictionary))
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
      
        // Setup formatter to handle the date conversion
        let formatter = NSDateFormatter()
        
        // Set date using configured formatter
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        formatter.dateStyle = .ShortStyle
        createdAtString = formatter.stringFromDate(createdAt!)
        
        // Set counts
        favoriteCount = dictionary["favorite_count"] as! Int
        retweetCount = dictionary["retweet_count"] as! Int
        
        id = dictionary["id_str"] as? String
        
        isFavorited = dictionary["favorited"] as? Bool
        isRetweeted = dictionary["retweeted"] as? Bool
        
    }
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
}
