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
    
    func fetchUser (uid: String, completion: @escaping(User) -> Void) {
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in

            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            
            completion(user)
            
            }
        }
        
}
    
