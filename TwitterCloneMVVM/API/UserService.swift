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
        
        REF_USERS.child(uid).observeSing
        
    }
    
}
