//
//  EditProfileCell.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 28.09.2022.
//

import UIKit

class EditProfileCell : UITableViewCell {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemCyan
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
}
