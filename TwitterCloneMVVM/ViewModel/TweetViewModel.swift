//
//  TweetViewModel.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 14.09.2022.
//

import UIKit

struct TweetViewModel {
    
    let tweet: Tweet
    let user: User
    
    
    var profileImageURL: URL? {
        return user.profileImageURL
    }
    
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timeStamp, to: now) ?? "000"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " ⏤ \(timeStamp)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    init(tweet: Tweet) {
        
        self.tweet = tweet
        self.user = tweet.user
        
    }
    
}
