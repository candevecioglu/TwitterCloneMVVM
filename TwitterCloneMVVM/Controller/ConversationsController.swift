//
//  ConversationsController.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 27.08.2022.
//

import UIKit

class ConversationsController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI () {
        
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
    
}
