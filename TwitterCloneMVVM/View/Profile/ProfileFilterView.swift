//
//  ProfileFilterView.swift
//  TwitterCloneMVVM
//
//  Created by M. Can Devecioğlu on 19.09.2022.
//

import UIKit

private let reuseIdentifier = "ProfileFilterCell"

protocol ProfileFilterViewDelegate: AnyObject {
    func filterView (_ view: ProfileFilterView, didSelect index: Int)
}

class ProfileFilterView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: ProfileFilterViewDelegate?
    
    lazy var collectionView: UICollectionView = {
       let layout         = UICollectionViewFlowLayout()
       let cv             = UICollectionView(frame: .zero, collectionViewLayout: layout)
       cv.backgroundColor = .white
       cv.delegate        = self
       cv.dataSource      = self
        return cv
    }()
    
    private let underLineView: UIView = {
       
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
        
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }
    
    override func layoutSubviews() {
        addSubview(underLineView)
        underLineView.anchor(left: leftAnchor, bottom: bottomAnchor,
                             width: frame.width / 3, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Datasource

extension ProfileFilterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOptions.allCases.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileFilterCell
        
        let option = ProfileFilterOptions(rawValue: indexPath.row)
        cell.option = option
        
        return cell
    }

}

//MARK: - Delagate

extension ProfileFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let xPosition = cell?.frame.origin.x ?? 0
            UIView.animate(withDuration: 0.3) {
                self.underLineView.frame.origin.x = xPosition
            }
        print("DEBUG: Delegate action to profile header from filter bar (ProfileFilterView)")
        delegate?.filterView(self, didSelect: indexPath.row)
    }


}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(ProfileFilterOptions.allCases.count)
        return CGSize(width: frame.width / count, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


