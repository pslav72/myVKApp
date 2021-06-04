//
//  NewsImageCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 08.05.2021.
//

import UIKit
import Kingfisher

class NewsImageCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsImageCell"
    static let nibName = "NewsImageCell"
    
    var photoURL: String = ""
    
    @IBOutlet var newsImageView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with news: NewsFeed) {
        newsImageView?.image = UIImage(systemName: "newspaper")
        if let indexAttachments = news.attachments.firstIndex(where: {$0.type == "photo"}),
           let indexPhoto = news.attachments[indexAttachments].photo?.sizes.firstIndex(where: {$0.type == "r"}) {
            self.photoURL = news.attachments[0].photo?.sizes[indexPhoto].url ?? ""
            newsImageView?.kf.setImage(with: URL(string: photoURL))
        }
        }
        

}
