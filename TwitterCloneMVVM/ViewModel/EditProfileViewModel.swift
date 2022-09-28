//
//  EditProfileViewModel.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 28.09.2022.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
            
        case .fullname: return "Fullname"
        case .username: return "Username"
        case .bio: return "Bio"
        }
    }
    
}
