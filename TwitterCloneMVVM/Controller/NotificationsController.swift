//
//  NotificationsController.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 27.08.2022.
//

import UIKit

class NotificationsController: UITableViewController {
    // MARK: - Properties
    
    private var notifications = [Notification]()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    // MARK: - Helpers
    
    func configureUI () {
        
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
    }
    
}


//MARK: - Extension

extension NotificationsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
