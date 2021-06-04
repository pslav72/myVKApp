//
//  NewsFooterCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 08.05.2021.
//

import UIKit

class NewsFooterCell: UITableViewCell {
    
    
    static let reuseIdentifier = "NewsFooterCell"
    static let nibName = "NewsFooterCell"
    
    @IBOutlet var newsCountViews: UILabel?
    
    @IBOutlet var newsLikeButton: UIButton?
    @IBOutlet var newsLikeCounts: UILabel?
    @IBOutlet var newsCommentsButton: UIButton?
    @IBOutlet var newsCommentsCounts: UILabel?
    @IBOutlet var newsSharedButton: UIButton?
    @IBOutlet var newsSharedCounts: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with news: NewsFeed) {
        newsCountViews?.text = String(news.views?.count ?? 0)
        newsLikeCounts?.text = String(news.likes?.count ?? 0)
        newsCommentsCounts?.text = String(news.comments?.count ?? 0)
        newsSharedCounts?.text = String(news.reposts?.count ?? 0)
    }

}
