//
//  FriendsPhotosViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 10.03.2021.
//

import UIKit

class FriendsPhotosViewController: UIViewController {
    
    var friendArrayPhotos: [UserPhotos] = []
    var heartImage: String = "heart"
    
    private var currentPhotoIndex: Int = 0
    
    @IBOutlet var friendsCurrentPhoto: UIImageView!
    @IBOutlet var friendsNextAppearingPhoto: UIImageView!
    
    @IBOutlet var friendLikeButton: UIButton!
    @IBOutlet var friendLikeCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        friendsCurrentPhoto.backgroundColor = .clear
//        friendsCurrentPhoto.image = friendArrayPhotos[currentPhotoIndex].image
        friendsCurrentPhoto.image = UIImage(systemName: "person")
        friendsCurrentPhoto.isUserInteractionEnabled = true
        friendsNextAppearingPhoto.backgroundColor = .clear
        friendsNextAppearingPhoto.isUserInteractionEnabled = true
        
        friendLikeCount.textColor = .systemBlue
//        friendLikeCount.text = String(friendArrayPhotos[currentPhotoIndex].likes.count)
        friendLikeCount.text = String(0)
//        print(friendArrayPhotos.count)
    }
    
    @IBAction func imageSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        guard currentPhotoIndex < friendArrayPhotos.count - 1 else {
            return
        }
        
        let newPhotoIndex: Int = currentPhotoIndex + 1
        let newPhoto = friendArrayPhotos[newPhotoIndex]
        
//        friendsNextAppearingPhoto.image = newPhoto.image
        friendsNextAppearingPhoto.image = UIImage(systemName: "person")
        friendsNextAppearingPhoto.transform = CGAffineTransform(translationX: self.view.bounds.width, y: CGFloat.random(in: 50...200))
        
        UIView.animate(withDuration: 1) { [self] in
            friendsCurrentPhoto.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: -(CGFloat.random(in: 50...200)))
            friendsNextAppearingPhoto.transform = .identity
        } completion: { [self] _ in
//            friendsCurrentPhoto.image = newPhoto.image
            friendsCurrentPhoto.image = UIImage(systemName: "person")
            friendsCurrentPhoto.transform = .identity
            friendsNextAppearingPhoto.transform = .identity
            currentPhotoIndex = newPhotoIndex
//            friendLikeCount.text = String(newPhoto.countsLike)
            friendLikeCount.text = "String(newPhoto.countsLike)"
//            heartImage = newPhoto.like ? "heart.fill" : "heart"
            heartImage = "heart.fill"
            friendLikeButton.setImage(UIImage(systemName: heartImage), for: [])
        }
    }
    
    @IBAction func imageSwipeRight(_ sender: UISwipeGestureRecognizer) {
        guard currentPhotoIndex > 0 else {
            return
        }
        let newPhotoIndex: Int = currentPhotoIndex - 1
//        let newPhoto = friendArrayPhotos[newPhotoIndex]
        
//        friendsNextAppearingPhoto.image = newPhoto.image
        friendsNextAppearingPhoto.image = UIImage(systemName: "person")
        friendsNextAppearingPhoto.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: CGFloat.random(in: 50...200))
        
        UIView.animate(withDuration: 1) { [self] in
            friendsCurrentPhoto.transform = CGAffineTransform(translationX: self.view.bounds.width, y: -(CGFloat.random(in: 50...200)))
            friendsNextAppearingPhoto.transform = .identity
        } completion: { [self] _ in
//            friendsCurrentPhoto.image = newPhoto.image
            friendsCurrentPhoto.image = UIImage(systemName: "person")
            friendsCurrentPhoto.transform = .identity
            friendsNextAppearingPhoto.transform = .identity
            currentPhotoIndex = newPhotoIndex
//            friendLikeCount.text = String(newPhoto.countsLike)
            friendLikeCount.text = "String(newPhoto.countsLike)"
//            heartImage = newPhoto.like ? "heart.fill" : "heart"
            heartImage = "heart.fill"
            friendLikeButton.setImage(UIImage(systemName: heartImage), for: [])

        }

        
    }
}
