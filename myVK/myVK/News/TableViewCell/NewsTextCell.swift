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
    
    @IBOutlet var newsTextLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with news: NewsFeed) {
        newsTextLabel?.text = news.text
    }
    
    
}
