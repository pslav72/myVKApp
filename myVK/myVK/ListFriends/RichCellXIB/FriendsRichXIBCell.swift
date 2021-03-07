//
//  RichXIBCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 03.03.2021.
//

import UIKit

class FriendsRichXIBCell: UITableViewCell {
    
    static let reuseIdentifier = "FriendsRichXIBCell"
    static let nibName = "FriendsRichXIBCell"
    
    @IBOutlet var friendsImageView: UIImageView! {
        didSet {
            self.friendsImageView.layer.backgroundColor = UIColor.systemFill.cgColor
        }
    }
    @IBOutlet var friendsShadowView: UIView!
    @IBOutlet var friendsNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        friendsImageView.clipsToBounds = true
        friendsShadowView.layer.shadowColor = UIColor.systemBlue.cgColor
        friendsShadowView.layer.shadowRadius = 3
        friendsShadowView.layer.shadowOpacity = 0.8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        friendsImageView.layer.cornerRadius = friendsImageView.bounds.width/2
        friendsShadowView.layer.cornerRadius = friendsShadowView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with friends: User) {
        friendsNameLabel.text = friends.name
        friendsImageView.image = friends.image
    }
    
}
