//
//  RichXIBCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 03.03.2021.
//

import UIKit
import Kingfisher

class FriendsRichXIBCell: UITableViewCell {
    
    static let reuseIdentifier = "FriendsRichXIBCell"
    static let nibName = "FriendsRichXIBCell"
    
    private lazy var imageFriends​TapGestureRecognizer: UITapGestureRecognizer = {
        let imageFriendsTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(actionTapImageFriends))
        imageFriendsTapRecogniser.numberOfTapsRequired = 1
        imageFriendsTapRecogniser.numberOfTouchesRequired = 1
        return imageFriendsTapRecogniser
    } ()
            
    
    @IBOutlet var friendsImageButton: UIImageView! {
        didSet {
            self.friendsImageButton.layer.backgroundColor = UIColor.systemFill.cgColor
        }
    }
    @IBOutlet var friendsShadowView: UIView!
    @IBOutlet var friendsNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        friendsImageButton.clipsToBounds = true
        friendsShadowView.layer.shadowColor = UIColor.systemBlue.cgColor
        friendsShadowView.layer.shadowRadius = 3
        friendsShadowView.layer.shadowOpacity = 0.8
        friendsImageButton.isUserInteractionEnabled = true
        friendsImageButton.addGestureRecognizer(imageFriends​TapGestureRecognizer)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        friendsImageButton.layer.cornerRadius = friendsImageButton.bounds.width/2
        friendsShadowView.layer.cornerRadius = friendsShadowView.bounds.width/2
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    public func configure(with friends: Friends) {
        friendsNameLabel.text = friends.name
        friendsImageButton.kf.setImage(with: URL(string: friends.photoURL))
    }
    
    
    @objc func actionTapImageFriends() {
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut]) {
            [self] in
            let affineScaleX: CGFloat = 0.2
            let affineScaleY: CGFloat = 0.2
            friendsImageButton.transform = CGAffineTransform(scaleX: affineScaleX, y: affineScaleY)
            friendsShadowView.transform = CGAffineTransform(scaleX: affineScaleX, y: affineScaleY)
        } completion: { _ in
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: []) {
                self.friendsImageButton.transform = .identity
                self.friendsShadowView.transform = .identity
            }
        }
    }
}
