//
//  User.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 10.09.2022.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

struct User {
    
    let fullname       : String
    let email          : String
    let username       : String
    var profileImageURL: URL?
    let uid            : String
    var isFollowed     = false
    var stats          : UserRelationStats?
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid             = uid
        self.fullname        = dictionary["fullname"] as? String ?? ""
        self.email           = dictionary["email"] as? String ?? ""
        self.username        = dictionary["username"] as? String ?? ""
        
        if let profileImageURLString = dictionary["profileImageURL"] as? String {
            guard let url = URL(string: profileImageURLString) else { return }
            self.profileImageURL = url
        }
        
        
    }
    
}

struct UserRelationStats {
    
    var followers: Int
    var following: Int
    
}
