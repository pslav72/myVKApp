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
    private lazy var friends: Results<Friends>? = try? Realm(configuration: realmService.config).objects(Friends.self)
    
    let operationQueue: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 1
        q.name = "ru.polyakov.operation.friendGet"
        q.qualityOfService = .userInitiated
        return q
    }()
    
    private var friendsNotificationToken: NotificationToken?
 
    var sectionedUsers: [UserSection] {
        
        friends!.reduce(into: []) { [weak self]
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
        

        
        friendsNotificationToken = friends?.observe { [weak self] changes in
            switch changes {
            case .initial:
                print("Initial")
//                self?.tableView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                print(deletions, insertions, modifications)
                self?.tableView.reloadData()
//                self?.tableView.apply(deletions: deletions, insertions: insertions, modifications: modifications)
            case let  .error(error):
                print(error)
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let friendsLoadingOperation = FriendsLoadingOperation()

        let friendsParseOperation = FriendsParseOperation()
        friendsParseOperation.addDependency(friendsLoadingOperation)


        let saveParseOperation = SaveParseOperation()
        saveParseOperation.addDependency(friendsParseOperation)
        
        operationQueue.addOperations([friendsLoadingOperation, friendsParseOperation, saveParseOperation], waitUntilFinished:  false)
        
//        vkApi.vkFriendsGet(completion: { [weak self] result in
//            switch result {
//            case let .failure(error):
//                print(error)
//            case let .success(friends):
//                do {
//                    try self?.realmService.save(items: friends)
////                    self?.tableView.reloadData()
//                } catch {
//                    print(error)
//                }
//
//            }
//        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        operationQueue.cancelAllOperations()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowFriendImageSegue",
//           let cellIndexPath = tableView.indexPathForSelectedRow,
//           let friendsCollectionViewController = segue.destination as? FriendsCollectionViewController {
//            let selectedFriends = sectionedUsers[cellIndexPath.section].users[cellIndexPath.row]
//            friendsCollectionViewController.friend = selectedFriends
//        }
        
        if segue.identifier == "ShowFriendImageADSegue",
           let cellIndexPath = tableView.indexPathForSelectedRow,
           let friendsCollectionViewController = segue.destination as? FriendsImageController {
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
//        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionedUsers[section].users.count
//        print(friends?.count ?? 4)
//        return friends?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsRichXIBCell.reuseIdentifier, for: indexPath) as? FriendsRichXIBCell else { return UITableViewCell() }
        cell.photoService = PhotoService.init(container: self.tableView)
        cell.configure(with: sectionedUsers[indexPath.section].users[indexPath.row], indexPath: indexPath)
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
//        performSegue(withIdentifier: "ShowFriendImageSegue", sender: nil)
//        performSegue(withIdentifier: "ShowFriendImageADSegue", sender: nil)
//        showAD(friend: sectionedUsers[])
        let friend: Friends = sectionedUsers[indexPath.section].users[indexPath.row]
        print(friend.id)
        showAD(friend: friend)
//        showImagePresentation()
        
    }
    
    private func showAD(friend: Friends) {
        let photoVC = FriendsImageController()
        photoVC.friend = friend
        photoVC.modalTransitionStyle = .crossDissolve
        photoVC.modalPresentationStyle = .overFullScreen
        present(photoVC, animated: false)
    }
    
    private func showImagePresentation() {
        let imageControllerPresentation = ImageControllerPresentation()
        imageControllerPresentation.modalTransitionStyle = .crossDissolve
        imageControllerPresentation.modalPresentationStyle = .pageSheet
        present(imageControllerPresentation, animated: false)
    }
    
    
}
