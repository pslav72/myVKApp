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
    {
        didSet {
            newsCountViews?.backgroundColor = .white
        }
    }
    @IBOutlet var newsLikeButton: UIButton?
    {
        didSet {
            newsLikeButton?.backgroundColor = .white
        }
    }
    @IBOutlet var newsLikeCounts: UILabel?
    {
        didSet {
            newsLikeCounts?.backgroundColor = .white
        }
    }
    @IBOutlet var newsCommentsButton: UIButton?
    {
        didSet {
            newsCommentsButton?.backgroundColor = .white
        }
    }
    @IBOutlet var newsCommentsCounts: UILabel?
    {
        didSet {
            newsCommentsCounts?.backgroundColor = .white
        }
    }
    @IBOutlet var newsSharedButton: UIButton?
    {
        didSet {
            newsSharedButton?.backgroundColor = .white
        }
    }
    @IBOutlet var newsSharedCounts: UILabel?
    {
        didSet {
            newsSharedCounts?.backgroundColor = .white
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
    
    public func configure(with news: NewsFeed) {
        newsCountViews?.text = String(news.views?.count ?? 0)
        newsLikeCounts?.text = String(news.likes?.count ?? 0)
        newsCommentsCounts?.text = String(news.comments?.count ?? 0)
        newsSharedCounts?.text = String(news.reposts?.count ?? 0)
    }

}
