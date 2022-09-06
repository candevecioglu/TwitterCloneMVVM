//
//  Constants.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 5.09.2022.
//

import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

let DB_REF                 = Database.database().reference()
let REF_USERS              = DB_REF.child("users")
let STORAGE_REF            = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_image")
