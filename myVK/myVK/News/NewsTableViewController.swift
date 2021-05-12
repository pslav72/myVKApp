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
    
//    var news = [
//        News(user: "Анна Петрова", userImage: UIImage(systemName: "person"), dataCreateNews: "2021-01-01 00:00:00", header: "Большая новость 1", image: UIImage(systemName: "person"), photos: [
//            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 1", like: true, countsLike: Int.random(in: 0...100)),
//            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 2", like: false, countsLike: Int.random(in: 0...100)),
//        ], newsComment: [
//            NewsComments(comment: "Комментарий 1", like: true, countsLike: Int.random(in: 0...1000)),
//            NewsComments(comment: "Комментарий 2", like: false, countsLike: Int.random(in: 0...1000)),
//            NewsComments(comment: "Комментарий 3", like: false, countsLike: Int.random(in: 0...1000)),
//        ]),
//        News(user: "Оля Иванова", userImage: UIImage(systemName: "person.2"), dataCreateNews: "2021-01-01 00:00:00", header: "Большая новость 2", image: UIImage(systemName: "person"), photos: [
//            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 1", like: false, countsLike: Int.random(in: 0...100)),
//            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 2", like: true, countsLike: Int.random(in: 0...100)),
//        ], newsComment: [
//            NewsComments(comment: "Комментарий 1", like: false, countsLike: Int.random(in: 0...1000)),
//            NewsComments(comment: "Комментарий 2", like: false, countsLike: Int.random(in: 0...1000)),
//            NewsComments(comment: "Комментарий 3", like: true, countsLike: Int.random(in: 0...1000)),
//        ]),
//        News(user: "Катя Ивановна", userImage: UIImage(systemName: "person"), dataCreateNews: "2021-01-01 00:00:00", header: "Большая новость 3", image: UIImage(systemName: "person"), photos: [
//            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 1", like: false, countsLike: Int.random(in: 0...100)),
//            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 2", like: true, countsLike: Int.random(in: 0...100)),
//            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 3", like: false, countsLike: Int.random(in: 0...100)),
//        ], newsComment: [
//            NewsComments(comment: "Комментарий 1", like: false, countsLike: Int.random(in: 0...1000)),
//            NewsComments(comment: "Комментарий 2", like: true, countsLike: Int.random(in: 0...1000)),
//            NewsComments(comment: "Комментарий 3", like: false, countsLike: Int.random(in: 0...1000)),
//        ]),
//    ]

    let vkApi = VKApi()
    let realmService = RealmService.self
    private lazy var newsFeed: Results<NewsFeed>? = try? Realm(configuration: realmService.config).objects(NewsFeed.self)
    
    private var newsNotificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsNotificationToken = newsFeed?.observe { [weak self] changes in
            switch changes {
            case .initial:
                print("Initial")
            case let .update(_, deletions, insertions, modifications):
                print(deletions, insertions, modifications)
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
            case let .success(newsFeed):
                do {
                    try self?.realmService.save(items: newsFeed)
                } catch {
                    print(error)
                }

            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("=> \(newsFeed?.count ?? 0)")
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
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderCell.reuseIdentifier, for: indexPath) as? NewsHeaderCell else {return UITableViewCell()}
//            cell.source_id = news[indexEntity].source_id
            cell.configure(with: news[indexEntity])
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseIdentifier, for: indexPath) as? NewsTextCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity])
            return cell
        }
        else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageCell.reuseIdentifier, for: indexPath) as? NewsImageCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity])
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterCell.reuseIdentifier, for: indexPath) as? NewsFooterCell else {return UITableViewCell()}
            cell.configure(with: news[indexEntity])
            return cell
        }

    }


}
