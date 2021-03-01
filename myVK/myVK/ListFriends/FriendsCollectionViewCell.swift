//
//  FriendsCollectionViewCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.02.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FriendsCell"
    
    var isLiked: Bool = false
    var countsLike: Int = 0
    var heartImage: String = "heart"
    
    @IBOutlet var friendCollectionImage: UIImageView!
    @IBOutlet var friendLikeButton: UIButton!
    @IBOutlet var friendLikeCount: UILabel!
    
    func configure(with friends: UserPhotos) {
        
        countsLike = friends.countsLike
        isLiked = friends.like
        heartImage = isLiked ? "heart.fill" : "heart"
        
        friendCollectionImage.image = friends.image
        friendLikeCount.text = String(countsLike)
        friendLikeButton.setTitle(friends.description, for: [])
        friendLikeButton.setImage(UIImage(systemName: heartImage), for: .normal)
        friendLikeButton.addTarget(self, action: #selector(buttonTappedLike), for: .touchUpInside)
        
    }
    
    
    @objc private func buttonTappedLike(_ sender: UIButton) {
        
        isLiked = isLiked ? false : true
        
        countsLike += isLiked ? 1 : -1
        heartImage = isLiked ? "heart.fill" : "heart"
        
        friendLikeButton.setImage(UIImage(systemName: heartImage), for: .normal)
        friendLikeCount.text = String(countsLike)
    }
    
}
