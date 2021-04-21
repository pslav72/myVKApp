//
//  FriendsCollectionViewCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.02.2021.
//

import UIKit
import Kingfisher

class FriendsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FriendsCell"
    
    var isLiked: Int = 0
    var countsLike: Int = 0
    var heartImage: String = "heart"
    
    var photoURL: String = ""
    
    @IBOutlet var friendCollectionImage: UIImageView!
    @IBOutlet var friendLikeButton: UIButton!
    @IBOutlet var friendLikeCount: UILabel!
    
    func configure(with friend: UserPhotos) {
        
        guard let friendLikes = friend.likes else { return }
        
        countsLike = friendLikes.count
        isLiked = friendLikes.user_likes

        if let indexPath = friend.sizes.firstIndex(where: {$0.type == "m"}) {
            self.photoURL = friend.sizes[indexPath].url
        }
        
        heartImage = (isLiked != 0) ? "heart.fill" : "heart"

        friendCollectionImage.kf.setImage(with: URL(string: photoURL))
        friendLikeCount.text = String(countsLike)
        friendLikeButton.setImage(UIImage(systemName: heartImage), for: .normal)
        friendLikeButton.addTarget(self, action: #selector(buttonTappedLike), for: .touchUpInside)
        
    }
    
    
    @objc private func buttonTappedLike(_ sender: UIButton) {
        
        isLiked = (isLiked != 0) ? 0 : 1
        
        countsLike += (isLiked != 0) ? 1 : -1
        heartImage = (isLiked != 0) ? "heart.fill" : "heart"
        
        friendLikeButton.setImage(UIImage(systemName: heartImage), for: .normal)
        friendLikeCount.text = String(countsLike)
        
        UIView.transition(with: friendLikeButton, duration: 3, options: [.transitionFlipFromTop]) {
        } completion: { _ in
        }
    }
    
}
