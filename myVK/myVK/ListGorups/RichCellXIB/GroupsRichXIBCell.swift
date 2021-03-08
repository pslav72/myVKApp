//
//  GroupsRichXIBCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 04.03.2021.
//

import UIKit

class GroupsRichXIBCell: UITableViewCell {
    
    static let reuseIdentifier = "GroupsRichXIBCell"
    static let nibName = "GroupsRichXIBCell"
    
    @IBOutlet var groupsButtomImage: UIButton! {
        didSet {
            self.groupsButtomImage.layer.backgroundColor = UIColor.systemFill.cgColor
        }
    }
    @IBOutlet var groupsNameLabel: UILabel!
    
    @IBAction func buttonPressedFriendsImage() {
        
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut]) {
            [self] in
            let affineScaleX: CGFloat = 0.2
            let affineScaleY: CGFloat = 0.2
            groupsButtomImage.transform = CGAffineTransform(scaleX: affineScaleX, y: affineScaleY)
        } completion: { _ in
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: []) {
                self.groupsButtomImage.transform = .identity
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with groups: Group) {
        groupsNameLabel.text = groups.name
        groupsButtomImage.setBackgroundImage(groups.image, for: [])
    }
    
}
