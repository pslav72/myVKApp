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
        User(name: "Anna", image:  UIImage(systemName: "person.3"), photos: [
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas", like: false, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas2", like: false, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas3", like: false, countsLike: Int.random(in: 0...100)),
        ]),
        User(name: "Yulija", image:  UIImage(systemName: "person.3"), photos: [
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas", like: false, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas2", like: false, countsLike: Int.random(in: 0...100)),
            UserPhotos(image: UIImage(systemName: "person"), description: "PhotoCoolStas3", like: false, countsLike: Int.random(in: 0...100)),
        ]),
    ]
    
    var sectionedUsers: [UserSection] {
        
        friends.reduce(into: []) {
            currentSectionUsers, user in
            guard let firstLetter = user.name.first else {return}
            
            if let currentSectionUsersStartingWithLetterIndex = currentSectionUsers.firstIndex(where: {$0.title == firstLetter}) {
                let oldSection = currentSectionUsers[currentSectionUsersStartingWithLetterIndex]
                let updateSection = UserSection(title: firstLetter, users: oldSection.users + [user])
                currentSectionUsers[currentSectionUsersStartingWithLetterIndex] = updateSection
            } else {
                let newSection = UserSection(title: firstLetter, users: [user])
                currentSectionUsers.append(newSection)
            }
        }.sorted()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: FriendsRichXIBCell.nibName, bundle: nil), forCellReuseIdentifier: FriendsRichXIBCell.reuseIdentifier)
        tableView.register(UserFirstLetterHeaderView.self, forHeaderFooterViewReuseIdentifier: UserFirstLetterHeaderView.reuseIdentifier)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendImageSegue",
           let cellIndexPath = tableView.indexPathForSelectedRow,
           let friendsCollectionViewController = segue.destination as? FriendsCollectionViewController {
            let selectedFriends = friends[cellIndexPath.row]
            friendsCollectionViewController.varFriends = selectedFriends
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionedUsers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionedUsers[section].users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsRichXIBCell.reuseIdentifier, for: indexPath) as? FriendsRichXIBCell else { return UITableViewCell() }
        
//        cell.configure(with: friends[indexPath.row])
        cell.configure(with: sectionedUsers[indexPath.section].users[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        String(sectionedUsers[section].title)
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserFirstLetterHeaderView.reuseIdentifier) as? UserFirstLetterHeaderView else { return nil}
        let firstLetter = String(sectionedUsers[section].title)
        
        header.headerTitle.text = firstLetter
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowFriendImageSegue", sender: nil)
    }
    
}
