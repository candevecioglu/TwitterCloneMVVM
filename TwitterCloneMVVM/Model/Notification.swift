//
//  Notification.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 23.09.2022.
//

import Foundation

enum NotificationType: Int {
    
    case follow
    case like
    case reply
    case retweet
    case mention
    
}

struct Notification {
    
    var tweetID: String?
    var timeStamp: Date!
    var user: User
    var tweet: Tweet?
    var type: NotificationType!
    
    init(user: User, dictionary: [String : AnyObject]) {
        
        self.user = user
        
        if let tweetID = dictionary["tweetID"] as? String {
            self.tweetID = tweetID
        }
        
        if let timeStamp = dictionary["timeStamp"] as? Double {
            self.timeStamp = Date(timeIntervalSince1970: timeStamp)
        }
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
    
}
