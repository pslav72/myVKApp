//
//  NewsTextCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 08.05.2021.
//

import UIKit

class NewsTextCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsTextCell"
    static let nibName = "NewsTextCell"
    static let horizontalInset: CGFloat = 12
    static let verticalInset: CGFloat = 0
    
    @IBOutlet var newsTextLabel: UILabel! {
        didSet {
            newsTextLabel.backgroundColor = .white
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.backgroundColor = .white
        newsTextLabel.backgroundColor = .white
        contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with news: NewsFeed, font: UIFont) {
        newsTextLabel.text = news.text
        newsTextLabel.numberOfLines = 0
        newsTextLabel.contentMode = .scaleToFill
        newsTextLabel.font = font
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        newsTextLabel.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height)
//    }
    
}
