//
//  FriendsPhotosViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 10.03.2021.
//

import UIKit
import Kingfisher


class FriendsPhotosViewController: UIViewController {
    
    var friendArrayPhotos: [UserPhotos] = []
    
    var isLiked: Int = 0
    var heartImage: String = "heart"
    var photoURL: String = ""
    var newPhotoURL: String = ""
    
    private var currentPhotoIndex: Int = 0
    
    @IBOutlet var friendsCurrentPhoto: UIImageView!
    @IBOutlet var friendsNextAppearingPhoto: UIImageView!
    
    @IBOutlet var friendLikeButton: UIButton!
    @IBOutlet var friendLikeCount: UILabel!
    
    func configure(with userPhotos: [UserPhotos], photoIndex: Int) {
        
        friendArrayPhotos = userPhotos
        currentPhotoIndex = photoIndex

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let indexPath = friendArrayPhotos[currentPhotoIndex].sizes.firstIndex(where: {$0.type == "m"}) {
            self.photoURL = friendArrayPhotos[currentPhotoIndex].sizes[indexPath].url
        }
        
        friendsCurrentPhoto.backgroundColor = .clear
        friendsCurrentPhoto.kf.setImage(with: URL(string: photoURL))
        friendsCurrentPhoto.isUserInteractionEnabled = true
        friendsNextAppearingPhoto.backgroundColor = .clear
        friendsNextAppearingPhoto.isUserInteractionEnabled = true
        
        friendLikeCount.textColor = .systemBlue
        if let likesCount = friendArrayPhotos[currentPhotoIndex].likes?.count {
            friendLikeCount.text = String(likesCount)
        }
    }

    @IBAction func imageSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        print(#function)
        guard currentPhotoIndex < friendArrayPhotos.count - 1 else {
            return
        }

        let newPhotoIndex: Int = currentPhotoIndex + 1
        
        if let indexPath = friendArrayPhotos[currentPhotoIndex].sizes.firstIndex(where: {$0.type == "m"}) {
            self.photoURL = friendArrayPhotos[currentPhotoIndex].sizes[indexPath].url
        }
        
        if let indexPath = friendArrayPhotos[newPhotoIndex].sizes.firstIndex(where: {$0.type == "m"}) {
            self.newPhotoURL = friendArrayPhotos[newPhotoIndex].sizes[indexPath].url
        }

        friendsCurrentPhoto.kf.setImage(with: URL(string: photoURL))
        friendsNextAppearingPhoto.transform = CGAffineTransform(translationX: self.view.bounds.width, y: CGFloat.random(in: 50...200))

        UIView.animate(withDuration: 1) { [self] in
            friendsCurrentPhoto.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: -(CGFloat.random(in: 50...200)))
            friendsNextAppearingPhoto.transform = .identity
        } completion: { [self] _ in
            friendsCurrentPhoto.kf.setImage(with: URL(string: newPhotoURL))
            friendsCurrentPhoto.transform = .identity
            friendsNextAppearingPhoto.transform = .identity
            currentPhotoIndex = newPhotoIndex
            if let likesCount = friendArrayPhotos[newPhotoIndex].likes?.count {
                friendLikeCount.text = String(likesCount)
            }
            if let userLike = friendArrayPhotos[newPhotoIndex].likes?.user_likes {
                heartImage = (userLike != 0) ? "heart.fill" : "heart"
            } else {
                heartImage = "heart.fill"
            }
            friendLikeButton.setImage(UIImage(systemName: heartImage), for: [])
        }
    }

    @IBAction func imageSwipeRight(_ sender: UISwipeGestureRecognizer) {
        print(#function)
        guard currentPhotoIndex > 0 else {
            return
        }
        
        let newPhotoIndex: Int = currentPhotoIndex - 1
        if let indexPath = friendArrayPhotos[newPhotoIndex].sizes.firstIndex(where: {$0.type == "m"}) {
            self.newPhotoURL = friendArrayPhotos[newPhotoIndex].sizes[indexPath].url
        }
        
        if let indexPath = friendArrayPhotos[currentPhotoIndex].sizes.firstIndex(where: {$0.type == "m"}) {
            self.photoURL = friendArrayPhotos[currentPhotoIndex].sizes[indexPath].url
        }

        friendsCurrentPhoto.kf.setImage(with: URL(string: photoURL))
        friendsNextAppearingPhoto.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: CGFloat.random(in: 50...200))

        UIView.animate(withDuration: 1) { [self] in
            friendsCurrentPhoto.transform = CGAffineTransform(translationX: self.view.bounds.width, y: -(CGFloat.random(in: 50...200)))
            friendsNextAppearingPhoto.transform = .identity
        } completion: { [self] _ in

            friendsCurrentPhoto.kf.setImage(with: URL(string: newPhotoURL))
            friendsCurrentPhoto.transform = .identity
            friendsNextAppearingPhoto.transform = .identity
            currentPhotoIndex = newPhotoIndex
            if let likesCount = friendArrayPhotos[newPhotoIndex].likes?.count {
                friendLikeCount.text = String(likesCount)
            }
            if let userLike = friendArrayPhotos[newPhotoIndex].likes?.user_likes {
                heartImage = (userLike != 0) ? "heart.fill" : "heart"
            } else {
                heartImage = "heart.fill"
            }
            friendLikeButton.setImage(UIImage(systemName: heartImage), for: [])

        }

    }
    
    
}
