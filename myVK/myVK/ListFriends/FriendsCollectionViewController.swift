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
    private lazy var friendPhotos: Results<UserPhotos> = try! Realm(configuration: realmService.config).objects(UserPhotos.self).filter("owner_id == %@",friend?.id ?? 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = friend?.name ?? "Empty"
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
                    self?.collectionView.reloadData()
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
        return friendPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell.reuseIdentifier, for: indexPath) as? FriendsCollectionViewCell
        else {return UICollectionViewCell()}

        let photos = friendPhotos[indexPath.item]
        cell.configure(with: photos)
        return cell

    }

}
