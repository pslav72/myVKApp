//
//  GroupsRichXIBCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 04.03.2021.
//

import UIKit
import Kingfisher

class GroupsRichXIBCell: UITableViewCell {
    
    static let reuseIdentifier = "GroupsRichXIBCell"
    static let nibName = "GroupsRichXIBCell"
    
    var photoService: PhotoService?
    
    @IBOutlet var groupsImageView: UIImageView! {
        didSet {
            self.groupsImageView.layer.backgroundColor = UIColor.systemFill.cgColor
        }
    }
    @IBOutlet var groupsNameLabel: UILabel! {
        didSet {
            groupsNameLabel.backgroundColor = .white
        }
    }
    
    private lazy var groupsImageViewTapGestureRecognizer: UITapGestureRecognizer = {
        let groupsImageViewTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(actionTapGroupsImageView))
        groupsImageViewTapRecogniser.numberOfTapsRequired = 1
        groupsImageViewTapRecogniser.numberOfTouchesRequired = 1
        return groupsImageViewTapRecogniser
    } ()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        groupsImageView.isUserInteractionEnabled = true
        groupsImageView.addGestureRecognizer(groupsImageViewTapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with groups: Group, indexPath: IndexPath) {
        
        let photoURL = groups.image
        let imageUser = photoService?.photo(atIndexpath: indexPath, byUrl: photoURL)
        
        if let image = imageUser {
            print("Load from photoService")
            groupsImageView.image = image
        } else {
            print("Load from kf")
            groupsImageView.kf.setImage(with: URL(string: photoURL))
        }
        
        groupsNameLabel.text = groups.name
//        groupsImageView.kf.setImage(with: URL(string: groups.image))
    }
    
    
    @objc func actionTapGroupsImageView() {
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut]) {
            [self] in
            let affineScaleX: CGFloat = 0.2
            let affineScaleY: CGFloat = 0.2
            groupsImageView.transform = CGAffineTransform(scaleX: affineScaleX, y: affineScaleY)
        } completion: { _ in
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: []) {
                self.groupsImageView.transform = .identity
            }
        }
    }
}
