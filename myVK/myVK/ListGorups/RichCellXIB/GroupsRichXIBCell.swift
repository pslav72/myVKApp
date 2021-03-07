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
    
    @IBOutlet var groupsImageView: UIImageView! {
        didSet {
            self.groupsImageView.layer.backgroundColor = UIColor.systemFill.cgColor
        }
    }
    @IBOutlet var groupsNameLabel: UILabel!

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
        groupsImageView.image = groups.image
    }
    
}
