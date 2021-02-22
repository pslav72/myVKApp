//
//  FriendsCollectionViewCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.02.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FriendsCell"
    
    @IBOutlet var friendCollectionImage: UIImageView!
    
    func configure(with friends: User) {
        
        friendCollectionImage.image = friends.image
        
    }
    
}
