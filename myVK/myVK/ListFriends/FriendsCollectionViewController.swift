//
//  FriendsCollectionViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.02.2021.
//

import UIKit

class FriendsCollectionViewController: UICollectionViewController {
    
    var varFriends: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = varFriends?.name
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return varFriends?.photos.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell.reuseIdentifier, for: indexPath) as? FriendsCollectionViewCell,
              let friend = varFriends?.photos[indexPath.item] else {return UICollectionViewCell()}

        cell.configure(with: friend)


        return cell
    }

}
