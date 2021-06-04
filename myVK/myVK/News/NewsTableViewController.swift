//
//  NewsTableViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 05.03.2021.
//

import UIKit
import Alamofire
import RealmSwift

class NewsTableViewController: UITableViewController {
    
    let vkApi = VKApi()
    let realmService = RealmService.self
    private lazy var newsFeed: Results<NewsFeed>? = try? Realm(configuration: realmService.config).objects(NewsFeed.self).sorted(byKeyPath: "date", ascending: false)
    
    private var newsNotificationToken: NotificationToken?
    
    
    var next_from: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vkApi.vkNewsFeed(completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(json):
//                do {
                    let newsFeedJSON = json["response"]["items"].arrayValue
                    let newsGroupsJSON = json["response"]["groups"].arrayValue
                    let newsProfilesJSON = json["response"]["profiles"].arrayValue
                    self?.next_from = json["response"]["next_from"].stringValue
                    let newsFeed = newsFeedJSON.map { NewsFeed(json: $0) }
                    let newsGroups = newsGroupsJSON.map { NewsGroup(json: $0) }
                    let newsProfiles = newsProfilesJSON.map { NewsProfiles(json: $0) }
                    DispatchQueue.global().async {
                        do {
                            try self?.realmService.save(items: newsFeed)
                        } catch  {
                            print(error)
                        }
                    }
                    DispatchQueue.global().async {
                        do {
                            try self?.realmService.save(items: newsGroups)
                        } catch  {
                            print(error)
                        }
                    }
                    DispatchQueue.global().async {
                        do {
                            try self?.realmService.save(items: newsProfiles)
                        } catch  {
                            print(error)
                        }
                    }
//                    try self?.realmService.save(items: newsFeed)
//                    try self?.realmService.save(items: newsGroups)
//                    try self?.realmService.save(items: newsProfiles)
//                } catch {
//                    print(error)
//                }

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
        
//        print("\(indexEntity) = \(indexPath.row) = \(newsFeed?.count) = \(next_from)")
        
        let nextValue = newsFeed!.count - 2
        
        if indexEntity == nextValue,
           indexPath.row == 0 {
            nextNews(nextFrom: next_from)
        }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderCell.reuseIdentifier, for: indexPath) as? NewsHeaderCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseIdentifier, for: indexPath) as? NewsTextCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity])
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageCell.reuseIdentifier, for: indexPath) as? NewsImageCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity])
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterCell.reuseIdentifier, for: indexPath) as? NewsFooterCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity])
            return cell
        default:
            return UITableViewCell()
        }

    }
    
    func nextNews(nextFrom: String) {
        
        let tt = vkApi
        tt.nextValue = nextFrom
        
        tt.vkNewsFeed(completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(json):
                do {
                    let newsFeedJSON = json["response"]["items"].arrayValue
                    let newsGroupsJSON = json["response"]["groups"].arrayValue
                    let newsProfilesJSON = json["response"]["profiles"].arrayValue
                    self?.next_from = json["response"]["next_from"].stringValue
                    let newsFeed = newsFeedJSON.map { NewsFeed(json: $0) }
                    let newsGroups = newsGroupsJSON.map { NewsGroup(json: $0) }
                    let newsProfiles = newsProfilesJSON.map { NewsProfiles(json: $0) }
                    try self?.realmService.save(items: newsFeed)
                    try self?.realmService.save(items: newsGroups)
                    try self?.realmService.save(items: newsProfiles)
                } catch {
                    print(error)
                }

            }
        })
        
    }


}
