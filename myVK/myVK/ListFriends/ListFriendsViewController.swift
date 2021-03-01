//
//  ListFriendsTableView.swift
//  myVK
//
//  Created by Вячеслав Поляков on 19.02.2021.
//

import UIKit

class ListFriendsViewController: UITableViewController {
    
    var friends = [
        User(name: "Oleg", image: UIImage(systemName: "person"), photos: [
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolOleg", like: false, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person.2"), description: "PhotoCoolOleg2", like: true, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person.3"), description: "PhotoCoolOleg3", like: false, countsLike: Int.random(in: 0...100))
        ]),
        User(name: "Vanja", image: UIImage(systemName: "person.2"), photos: [
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolVanja", like: true, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person.2"), description: "PhotoCoolVanja2", like: false, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person.3"), description: "PhotoCoolVanja3", like: true, countsLike: Int.random(in: 0...100)),
        ]),
        User(name: "Stas", image:  UIImage(systemName: "person.3"), photos: [
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas", like: false, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas2", like: false, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas3", like: false, countsLike: Int.random(in: 0...100)),
        ]),
        User(name: "Roma", image:  UIImage(systemName: "person"), photos: [
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolRoma", like: true, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person.3"), description: "PhotoCoolRoma2", like: true, countsLike: Int.random(in: 0...100)),
        ]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendImageSegue",
           let senderCell = sender as? FriendsCell,
           let cellIndexPath = tableView.indexPath(for: senderCell),
           let friendsCollectionViewController = segue.destination as? FriendsCollectionViewController {
            let selectedFriends = friends[cellIndexPath.row]
            friendsCollectionViewController.varFriends = selectedFriends
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellFriend", for: indexPath) as? FriendsCell else { return UITableViewCell() }
        
        cell.friendsLabel.text = friends[indexPath.row].name
        cell.friendsViewImage.image = friends[indexPath.row].image
        
        return cell
    }
    
}
