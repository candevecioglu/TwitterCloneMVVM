//
//  Tweet.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 12.09.2022.
//

import Foundation

struct Tweet {
    
    let caption: String
    let tweetID: String
    var likes: Int
    var timeStamp: Date!
    let retweetCount: Int
    var user: User
    var didLike = false
    var replyingTo: String?
    
    var isReply: Bool { return replyingTo != nil }
    
    
    init(user: User, tweetID: String, dictionary: [String : Any]) {
        
        self.tweetID = tweetID
        self.user = user

        self.caption        = dictionary["caption"] as? String ?? ""
        self.likes          = dictionary["likes"] as? Int ?? 0
        self.retweetCount   = dictionary["retweets"] as? Int ?? 0
        
        if let timeStamp = dictionary["timeStamp"] as? Double {
            self.timeStamp = Date(timeIntervalSince1970: timeStamp)
        }
        
        if let replyingTo = dictionary["replyingTo"] as? String {
            self.replyingTo = replyingTo
        }
    }
}
