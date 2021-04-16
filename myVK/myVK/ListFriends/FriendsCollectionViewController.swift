//
//  FriendsCollectionViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.02.2021.
//

import UIKit

class FriendsCollectionViewController: UICollectionViewController {
    
    let vkApi = VKApi()
    var friend: Friends?
    var friendPhotos: [UserPhotos] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = friend?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
//        print(friend?.id)
        
        vkApi.vkphotosGet(owner_id: friend?.id ?? 0, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friendPhotos):
                print(friendPhotos.count)
//                print(friendPhotos)
                self?.friendPhotos = friendPhotos
                self?.collectionView.reloadData()
            }
        })
//        print(self.friends)
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
