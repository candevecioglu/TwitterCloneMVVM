//
//  TweetService.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 12.09.2022.
//

import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

struct TweetService {
    
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void ) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let username = Auth.auth().currentUser?.email else { return }
        
        let values = ["uid": uid,
                      "timeStamp": Int(NSTimeIntervalSince1970),
                      "likes": 0, "retweets": 0,
                      "caption": caption,
                      "user": username] as [String : Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            
            let tweetID = snapshot.key
            
            let tweet = Tweet(tweetID: tweetID, dictionary: dictionary)
            
            tweets.append(tweet)
            completion(tweets)
            
        }
        
    }
    
}
