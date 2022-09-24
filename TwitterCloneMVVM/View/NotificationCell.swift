//
//  NotificationCell.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 24.09.2022.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    
    var notification: Notification? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 40, height: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.text = "Bu bir test bildirimidir"
        return label
    }()
    
    //MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, notificationLabel])
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .center
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        stack.anchor(right: rightAnchor, paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc func handleProfileImageTapped () {
        print("DEBUG: Row tapped")
    }
    
    //MARK: - Helpers
    
    func configure () {
        
        guard let notification = notification else { return }
        let viewModel = NotificationViewModel(notification: notification)
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        notificationLabel.attributedText = viewModel.notificationText
        
    }
    
}
