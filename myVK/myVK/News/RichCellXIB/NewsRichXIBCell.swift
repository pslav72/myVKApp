//
//  NewsRichXIBCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 05.03.2021.
//

import UIKit

class NewsRichXIBCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsRichXIBCell"
    static let nibName = "NewsRichXIBCell"
    
    @IBOutlet var userImageView: UIImageView! {
        didSet {
            self.userImageView.layer.backgroundColor = UIColor.systemFill.cgColor
        }
    }
    @IBOutlet var userShadowView: UIView!
    @IBOutlet var userNameLabel: UILabel! {
        didSet {
            self.userNameLabel.textAlignment = .left
            self.userNameLabel.textColor = .black
        }
    }
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var dataCreateNews: UILabel! {
        didSet {
            self.dataCreateNews.textAlignment = .left
            self.dataCreateNews.textColor = .black
        }
    }
    
    @IBOutlet var newsCountViews: UILabel! {
        didSet {
            self.newsCountViews.text = String(Int.random(in: 0...100))
        }
    }
    
    @IBOutlet var newsLikeButton: UIButton!
    @IBOutlet var newsLikeCounts: UILabel! {
        didSet {
            self.newsLikeCounts.text = String(Int.random(in: 0...100))
        }
    }
    @IBOutlet var newsCommentsButton: UIButton!
    @IBOutlet var newsCommentsCounts: UILabel! {
        didSet {
            self.newsCommentsCounts.text = String(Int.random(in: 0...100))
        }
    }
    @IBOutlet var newsSharedButton: UIButton!
    @IBOutlet var newsSharedCounts: UILabel!  {
        didSet {
            self.newsSharedCounts.text = String(Int.random(in: 0...100))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.clipsToBounds = true
        userShadowView.layer.shadowColor = UIColor.systemBlue.cgColor
        userShadowView.layer.shadowRadius = 3
        userShadowView.layer.shadowOpacity = 0.8
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.bounds.width/2
        userShadowView.layer.cornerRadius = userShadowView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with news: News) {
        userImageView.image = news.userImage
        userNameLabel.text = news.user
        dataCreateNews.text = news.dataCreateNews
        newsImage.image = news.image
    }
    
}
