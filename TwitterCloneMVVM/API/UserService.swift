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
    
    func fetchUsers (completion: @escaping([User]) -> Void) {
        
        var users = [User]()
        
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String : AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
        
    }
    
    func followUser (uid: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currentUID).updateChildValues([uid : 1]) { err, ref in
            REF_USER_FOLLOWERS.child(uid).updateChildValues([currentUID : 1], withCompletionBlock: completion)
        }
        
    }
        
}
    
