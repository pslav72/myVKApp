//
//  ListFriendsTableView.swift
//  myVK
//
//  Created by Вячеслав Поляков on 19.02.2021.
//

import UIKit
import Alamofire
import RealmSwift


class ListFriendsViewController: UITableViewController {
    
    let vkApi = VKApi()
    let realmService = RealmService.self
    private lazy var friends: Results<Friends> = try! Realm(configuration: realmService.config).objects(Friends.self)
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vkApi.vkFriendsGet(completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                do {
                    try self?.realmService.save(items: friends)
                    self?.tableView.reloadData()
                } catch {
                    print(error)
                }

            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendImageSegue",
           let cellIndexPath = tableView.indexPathForSelectedRow,
           let friendsCollectionViewController = segue.destination as? FriendsCollectionViewController {
            let selectedFriends = sectionedUsers[cellIndexPath.section].users[cellIndexPath.row]
            friendsCollectionViewController.friend = selectedFriends
        }
        
//        if segue.identifier == "ShowFriendPhotoSegue",
//           let cellIndexPath = tableView.indexPathForSelectedRow,
//           let friendsPhotosViewController = segue.destination as? FriendsPhotosViewController {
//            let selectedFriends = sectionedUsers[cellIndexPath.section].users[cellIndexPath.row].photos
//            friendsPhotosViewController.friendArrayPhotos = selectedFriends
//        }
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
        
        cell.configure(with: sectionedUsers[indexPath.section].users[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserFirstLetterHeaderView.reuseIdentifier) as? UserFirstLetterHeaderView else { return nil}
        let firstLetter = String(sectionedUsers[section].title)
        
        header.headerTitle.text = firstLetter
        
        return header
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "ShowFriendImageSegue", sender: nil)
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowFriendImageSegue", sender: nil)
    }
    
    
}
