//
//  RegistrationController.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 27.08.2022.
//

import UIKit

class RegistrationController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI () {
        view.backgroundColor = .twitterBlue
    }

}

