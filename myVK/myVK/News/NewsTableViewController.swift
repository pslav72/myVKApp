//
//  NewsTableViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 05.03.2021.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class NewsTableViewController: UITableViewController {
    
    let vkApi = VKApi()
    let realmService = RealmService.self
    private lazy var newsFeed: Results<NewsFeed>? = try? Realm(configuration: realmService.config).objects(NewsFeed.self).sorted(byKeyPath: "date", ascending: false)
    
    private var newsNotificationToken: NotificationToken?

    private var nextFrom: String? = nil
    private var isNewsLoading: Bool = false
    private var newsJson: JSON? = nil
    private let textNewsFont = UIFont.systemFont(ofSize: 14)
    private var opennedText: [IndexPath: Bool] = [:]
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateStyle = .medium
        df.timeStyle = .medium
//        df.dateFormat = "HH:mm dd MMMM"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        newsNotificationToken = newsFeed?.observe { [weak self] changes in
            switch changes {
            case .initial:
                print("Initial")
            case let .update(_, deletions, insertions, modifications):
//                print(deletions, insertions, modifications)
                self?.tableView.reloadData()
            case let  .error(error):
                print(error)
            }
        }
        
        tableView.prefetchDataSource = self
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Loadiinnnggggsssss...")
        refreshControl?.tintColor = .systemBlue
        refreshControl?.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
    }
    
    @objc private func refreshControlPulled () {
        
        guard let firstPost = newsFeed?.first else {
            refreshControl?.endRefreshing()
            return
        }
        
//        let dispatchGroup = DispatchGroup()
        
        vkApi.vkNewsFeed(startTime: firstPost.date + 1,  completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(json):
                
                self?.newsJson = json["response"]
                if let newsJson = self?.newsJson {
                    self?.saveNews(with: newsJson)
                }
                
//                var newsFeedJSON: [JSON] = []
//                var newsGroupsJSON: [JSON] = []
//                var newsProfilesJSON: [JSON] = []
//
//                var newsFeed: [NewsFeed] = []
//                var newsGroups: [NewsGroup] = []
//                var newsProfiles: [NewsProfiles] = []
//
//                DispatchQueue.global().async(group: dispatchGroup) {
//                    newsFeedJSON = json["response"]["items"].arrayValue
//                    newsFeed = newsFeedJSON.map { NewsFeed(json: $0) }
//                }
//                DispatchQueue.global().async(group: dispatchGroup) {
//                    newsGroupsJSON = json["response"]["groups"].arrayValue
//                    newsGroups = newsGroupsJSON.map { NewsGroup(json: $0) }
//                }
//                DispatchQueue.global().async(group: dispatchGroup) {
//                    newsProfilesJSON = json["response"]["profiles"].arrayValue
//                    newsProfiles = newsProfilesJSON.map { NewsProfiles(json: $0) }
//                }
//
//                self?.nextFrom = json["response"]["next_from"].stringValue
//
//                dispatchGroup.notify(queue: DispatchQueue.global()) {
//                    DispatchQueue.main.async(group: dispatchGroup) {
//                        do {
//                            try self?.realmService.save(items: newsFeed)
//                        } catch  {
//                            print(error)
//                        }
//                    }
//                    DispatchQueue.main.async(group: dispatchGroup) {
//                        do {
//                            try self?.realmService.save(items: newsGroups)
//                        } catch  {
//                            print(error)
//                        }
//                    }
//                    DispatchQueue.main.async(group: dispatchGroup) {
//                        do {
//                            try self?.realmService.save(items: newsProfiles)
//                        } catch  {
//                            print(error)
//                        }
//                    }
//                }
//
            }
        })
        
        refreshControl?.endRefreshing()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let dispatchGroup = DispatchGroup()
//        var newsJson: JSON? = nil
        
        vkApi.vkNewsFeed(completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(json):
                self?.newsJson = json["response"]
                if let newsJson = self?.newsJson {
                    self?.saveNews(with: newsJson)
                }
//                var newsFeedJSON: [JSON] = []
//                var newsGroupsJSON: [JSON] = []
//                var newsProfilesJSON: [JSON] = []
//
//                var newsFeed: [NewsFeed] = []
//                var newsGroups: [NewsGroup] = []
//                var newsProfiles: [NewsProfiles] = []
//
//                DispatchQueue.global().async(group: dispatchGroup) {
//                    newsFeedJSON = json["response"]["items"].arrayValue
//                    newsFeed = newsFeedJSON.map { NewsFeed(json: $0) }
//                }
//                DispatchQueue.global().async(group: dispatchGroup) {
//                    newsGroupsJSON = json["response"]["groups"].arrayValue
//                    newsGroups = newsGroupsJSON.map { NewsGroup(json: $0) }
//                }
//                DispatchQueue.global().async(group: dispatchGroup) {
//                    newsProfilesJSON = json["response"]["profiles"].arrayValue
//                    newsProfiles = newsProfilesJSON.map { NewsProfiles(json: $0) }
//                }
//
//                self?.nextFrom = json["response"]["next_from"].stringValue
//
//                dispatchGroup.notify(queue: DispatchQueue.global()) {
//                    DispatchQueue.main.async(group: dispatchGroup) {
//                        do {
//                            try self?.realmService.save(items: newsFeed)
//                        } catch  {
//                            print(error)
//                        }
//                    }
//                    DispatchQueue.main.async(group: dispatchGroup) {
//                        do {
//                            try self?.realmService.save(items: newsGroups)
//                        } catch  {
//                            print(error)
//                        }
//                    }
//                    DispatchQueue.main.async(group: dispatchGroup) {
//                        do {
//                            try self?.realmService.save(items: newsProfiles)
//                        } catch  {
//                            print(error)
//                        }
//                    }
//                }
//
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsFeed?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let indexEntity = indexPath.section
        
        guard let news = newsFeed else {
            return UITableViewCell()
        }
        
//        let nextValue = newsFeed!.count - 2
//
//        if indexEntity == nextValue,
//           indexPath.row == 0 {
//            nextNews(nextFrom: next_from)
//        }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderCell.reuseIdentifier, for: indexPath) as? NewsHeaderCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity], dateFormatter: dateFormatter)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseIdentifier, for: indexPath) as? NewsTextCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.configure(with: news[indexEntity], font: textNewsFont)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageCell.reuseIdentifier, for: indexPath) as? NewsImageCell else {return UITableViewCell()}
            cell.photoService = PhotoService.init(container: self.tableView)
            cell.configure(with: news[indexEntity], indexPath: indexPath)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterCell.reuseIdentifier, for: indexPath) as? NewsFooterCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity])
            return cell
        default:
            return UITableViewCell()
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let news = newsFeed else {
            return UITableView.automaticDimension
        }
        
        switch indexPath.row {
        case 1:
            let text = news[indexPath.section].text
            guard !text.isEmpty else {
                return 0
            }
            
            let maximumCellHeight: CGFloat = 100
            
            let availableWidth = tableView.frame.width - 2 * NewsTextCell.horizontalInset
            let desiredLabelHeight = getLabelSize(text: text, font: textNewsFont, availableWidth: availableWidth).height + 2 * NewsTextCell.verticalInset
            let isOpened: Bool = opennedText[indexPath] ?? false
            if isOpened {
                return desiredLabelHeight
            }
            return isOpened ? desiredLabelHeight : min(maximumCellHeight, desiredLabelHeight)
            
        case 2:
            var aspectRation: CGFloat {
                if let indexAttachments = news[indexPath.section].attachments.firstIndex(where: {$0.type == "photo"}),
                   let indexPhoto = news[indexPath.section].attachments[indexAttachments].photo?.sizes.firstIndex(where: {$0.type == "r"}) {
                    return news[indexPath.section].attachments[0].photo?.sizes[indexPhoto].aspectRation ?? 0
                }
                return 0
            }
            return tableView.frame.width * aspectRation
        default:
//            let height: CGFloat = 44
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let news = newsFeed else {
            return UITableView.automaticDimension
        }
        
        switch indexPath.row {
        case 1:
            let text = news[indexPath.section].text
            guard !text.isEmpty else {
                return 0
            }
            let maximumCellHeight: CGFloat = 100
            let availableWidth = tableView.frame.width - 2 * NewsTextCell.horizontalInset
            let desiredLabelHeight = getLabelSize(text: text, font: textNewsFont, availableWidth: availableWidth).height + 2 * NewsTextCell.verticalInset
            return min(maximumCellHeight, desiredLabelHeight)
        case 2:
            var aspectRation: CGFloat {
                if let indexAttachments = news[indexPath.section].attachments.firstIndex(where: {$0.type == "photo"}),
                   let indexPhoto = news[indexPath.section].attachments[indexAttachments].photo?.sizes.firstIndex(where: {$0.type == "r"}) {
                    return news[indexPath.section].attachments[0].photo?.sizes[indexPhoto].aspectRation ?? 0
                }
                return 0
            }
            return tableView.frame.width * aspectRation
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 1 else {
            return
        }
        let currentValue = opennedText[indexPath] ?? false
        opennedText[indexPath] = !currentValue
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func saveNews (with newsJson: JSON) {
        
        let dispatchGroup = DispatchGroup()
        
        var newsFeedJSON: [JSON] = []
        var newsGroupsJSON: [JSON] = []
        var newsProfilesJSON: [JSON] = []
        
        var newsFeed: [NewsFeed] = []
        var newsGroups: [NewsGroup] = []
        var newsProfiles: [NewsProfiles] = []
        
        DispatchQueue.global().async(group: dispatchGroup) {
            newsFeedJSON = newsJson["items"].arrayValue
            newsFeed = newsFeedJSON.map { NewsFeed(json: $0) }
        }
        DispatchQueue.global().async(group: dispatchGroup) {
            newsGroupsJSON = newsJson["groups"].arrayValue
            newsGroups = newsGroupsJSON.map { NewsGroup(json: $0) }
        }
        DispatchQueue.global().async(group: dispatchGroup) {
            newsProfilesJSON = newsJson["profiles"].arrayValue
            newsProfiles = newsProfilesJSON.map { NewsProfiles(json: $0) }
        }
        
        self.nextFrom = newsJson["next_from"].stringValue
        
        dispatchGroup.notify(queue: DispatchQueue.global()) {
            DispatchQueue.main.async(group: dispatchGroup) {
                do {
                    try self.realmService.save(items: newsFeed)
                } catch  {
                    print(error)
                }
            }
            DispatchQueue.main.async(group: dispatchGroup) {
                do {
                    try self.realmService.save(items: newsGroups)
                } catch  {
                    print(error)
                }
            }
            DispatchQueue.main.async(group: dispatchGroup) {
                do {
                    try self.realmService.save(items: newsProfiles)
                } catch  {
                    print(error)
                }
            }
        }
        
    }
    
    func getLabelSize(text: String, font: UIFont, availableWidth: CGFloat) -> CGSize {
        let textBlock = CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    

}


extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        guard let nextFrom = nextFrom,
              let maxIndexPath = indexPaths.max(),
              let newsFeed = newsFeed,
              maxIndexPath.section >= (newsFeed.count - 3),
              !isNewsLoading
              else {
                return
        }
        
        isNewsLoading = true
        
        vkApi.vkNewsFeed(nextFrom: nextFrom, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(json):
                
                self?.newsJson = json["response"]
                if let newsJson = self?.newsJson {
                    self?.saveNews(with: newsJson)
                }
                
            }

            self?.isNewsLoading = false

        })
    }
    
    
}
