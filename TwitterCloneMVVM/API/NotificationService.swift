//
//  NotificationService.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 23.09.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

struct NotificationService {
    
    static let shared = NotificationService()
    
    func uploadNotification(toUser user: User,
                            type: NotificationType,
                            tweetID: String? = nil) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var values: [String : Any] = ["timeStamp": Int(NSDate().timeIntervalSince1970),
                                      "uid": uid,
                                      "type": type.rawValue]
        if let tweetID = tweetID {
            values["tweetID"] = tweetID
            
        }
        
        REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
        
    }
    
    func fetchNotifications (completion: @escaping([Notification]) -> Void) {
        
        var notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_NOTIFICATIONS.child(uid).observe(.childAdded) { snapshot in
            
            guard let dictionary = snapshot.value as? [String : AnyObject] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            UserService.shared.fetchUser(uid: uid) { user in
                let notification = Notification(user: user, dictionary: dictionary)
                notifications.append(notification)
                completion(notifications)
            }
        }
    }
    
}
