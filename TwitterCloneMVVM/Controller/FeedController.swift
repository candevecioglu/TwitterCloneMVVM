//
//  FeedController.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 27.08.2022.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { configureLeftBarButton() }
    }
    
    private var tweets = [Tweet]() {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchTweets()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            
            self.tweets = tweets
        }
        
    }
    
    // MARK: - Helpers
    
    func configureUI () {
        
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        
    }
    
    func configureLeftBarButton () {
        
        guard let user = user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
}

// MARK: - Delegate / Datasource

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TweetController(tweet: tweets[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
}

// MARK: - Delegate Flow Layout

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewModel = TweetViewModel(tweet: tweets[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height
        
        return CGSize(width: view.frame.width, height: height + 72)
    }
    
}

// MARK: - TweetCell Delegate

extension FeedController: TweetCellDelegate {
    
    func handleProfileImageTapped(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func handleReplyTapped (_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        let controller = UploadTweetController(user: tweet.user, config: .reply(tweet))
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    
    
}
