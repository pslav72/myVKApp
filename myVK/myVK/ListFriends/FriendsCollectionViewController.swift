//
//  FriendsCollectionViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.02.2021.
//

import UIKit
import RealmSwift

class FriendsCollectionViewController: UICollectionViewController {
    
    let vkApi = VKApi()
    let realmService = RealmService.self
    var friend: Friends?
    private lazy var friendPhotos: Results<UserPhotos>? = try? Realm(configuration: realmService.config).objects(UserPhotos.self).filter("owner_id == %@",friend?.id ?? 0)
    private var friendPhotosNotificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = friend?.name ?? "Empty"
        
        friendPhotosNotificationToken = friendPhotos?.observe { [weak self] changes in
            switch changes {
            case .initial:
                print("Initial")
            case let .update(_, deletions, insertions, modifications):
                print(deletions, insertions, modifications)
                self?.collectionView.applyNotificationToken(deletions: deletions, insertions: insertions, modifications: modifications)
            case let  .error(error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vkApi.vkphotosGet(owner_id: friend?.id ?? 0, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friendPhotos):
                do {
                    try self?.realmService.save(items: friendPhotos)
//                    self?.collectionView.reloadData()
                } catch {
                    print(error)
                }
            }
        })
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhotos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell.reuseIdentifier, for: indexPath) as? FriendsCollectionViewCell,
              let friend = friendPhotos
        else {return UICollectionViewCell()}
        
        cell.configure(with: friend[indexPath.item])
        return cell
    }

}
