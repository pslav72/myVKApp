//
//  NewsImageCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 08.05.2021.
//

import UIKit
import Kingfisher

class NewsImageCell: UITableViewCell {
    
    private let imageWidth: CGFloat = 250
    
    static let reuseIdentifier = "NewsImageCell"
    static let nibName = "NewsImageCell"
    
    var photoService: PhotoService?
    var photoURL: String = ""
    
    @IBOutlet var newsImageView: UIImageView!
    {
        didSet {
            newsImageView.backgroundColor = .white
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.setNeedsLayout()
//        self.layoutIfNeeded()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with news: NewsFeed, indexPath: IndexPath) {
        newsImageView.image = UIImage(systemName: "newspaper")
        if let indexAttachments = news.attachments.firstIndex(where: {$0.type == "photo"}),
           let indexPhoto = news.attachments[indexAttachments].photo?.sizes.firstIndex(where: {$0.type == "r"}) {
            photoURL = news.attachments[0].photo?.sizes[indexPhoto].url ?? ""
            
            let imageUser = photoService?.photo(atIndexpath: indexPath, byUrl: photoURL)
            if let image = imageUser {
                print("Load from photoService")
                newsImageView.image = image
            } else {
                print("Load from kf")
                newsImageView.kf.setImage(with: URL(string: photoURL))
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.bounds = CGRect(x: self.bounds.origin.x,
//                             y: self.bounds.origin.y,
//                             width: self.bounds.size.width,
//                             height: 300)
        
//        let frameX: CGFloat = ((contentView.bounds.width - imageWidth)/2).rounded()
//        let frameY: CGFloat = ((contentView.bounds.height - imageWidth)/2).rounded()

        newsImageView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height)
    }
    

}
