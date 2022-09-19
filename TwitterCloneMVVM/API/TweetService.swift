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
        
        let ref = REF_TWEETS.childByAutoId()
        
        ref.updateChildValues(values) { err, ref in
            // update user_tweet structure after tweet upload complete!
            guard let tweetID = ref.key else { return }
            REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
        }
        
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }

            
        }
        
    }
    
    func fetchTweets (forUser user: User, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
            let tweetID = snapshot.key
            
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String : Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                UserService.shared.fetchUser(uid: uid) { user in
                    let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    
    }
    
}
