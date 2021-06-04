//
//  NewsHeaderCell.swift
//  myVK
//
//  Created by Вячеслав Поляков on 08.05.2021.
//

import UIKit
import RealmSwift


class NewsHeaderCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsHeaderCell"
    var source_id: Int = 0
    var photoURL: String = ""
    
    @IBOutlet var userNameLabel: UILabel?
    @IBOutlet var dataCreateNews: UILabel?
    @IBOutlet var userImageView: UIImageView?
    
    let vkApi = VKApi()
    let realmService = RealmService.self
    var news: NewsFeed?
//    private lazy var ownerGroupNews: Results<Group>? = try? Realm(configuration: realmService.config).objects(Group.self).filter("id == %@",-source_id)
//    private lazy var ownerFriendsNews: Results<Friends>? = try? Realm(configuration: realmService.config).objects(Friends.self).filter("id == %@",source_id)
    
    private var newsNotificationToken: NotificationToken?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with news: NewsFeed) {
        self.source_id = news.source_id
        
        let ownerGroupNews: Results<NewsGroup>? = try? Realm(configuration: realmService.config).objects(NewsGroup.self).filter("id == %@",-source_id)
        let ownerFriendsNews: Results<NewsProfiles>? = try? Realm(configuration: realmService.config).objects(NewsProfiles.self).filter("id == %@",source_id)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let date = Date(timeIntervalSince1970: TimeInterval(news.date))
        dataCreateNews?.text = dateFormatter.string(from: date)
        
        if news.source_id < 0 {
            userNameLabel?.text = ownerGroupNews?.first?.name ?? "Bugs"
            self.photoURL = ownerGroupNews?.first?.photo_50 ?? ""
            userImageView?.kf.setImage(with: URL(string: photoURL))
        } else {
            userNameLabel?.text = ownerFriendsNews?.first?.name ?? "Bugs"
            self.photoURL = ownerFriendsNews?.first?.photoURL ?? ""
            userImageView?.kf.setImage(with: URL(string: photoURL))
        }
    
    }

}
