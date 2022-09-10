//
//  UserService.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 9.09.2022.
//

import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

struct UserService {
    static let shared = UserService()
    
    func fetchUser () {
        print("DEBUG: Fetch current user datas!")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("DEBUG: \(uid)")
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            print("DEBUG: Snapshot is \(snapshot)")
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            guard let username = dictionary["username"] as? String else { return }
            print("DEBUG: Username is \(username)")
            
            }
        }
        
}
    
