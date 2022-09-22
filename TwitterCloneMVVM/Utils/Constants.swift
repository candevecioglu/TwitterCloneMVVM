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
let STORAGE_REF            = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_image")
let REF_USERS              = DB_REF.child("users")
let REF_TWEETS             = DB_REF.child("tweets")
let REF_USER_TWEETS        = DB_REF.child("user_tweets")
let REF_USER_FOLLOWERS     = DB_REF.child("user_followers")
let REF_USER_FOLLOWING     = DB_REF.child("user_following")
let REF_TWEET_REPLIES      = DB_REF.child("tweet_replies")
