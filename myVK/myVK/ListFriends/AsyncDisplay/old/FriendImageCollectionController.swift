////
////  FriendImageCollectionController.swift
////  myVK
////
////  Created by Вячеслав Поляков on 08.06.2021.
////
//
//import UIKit
//import AsyncDisplayKit
//import RealmSwift
//
//class FriendImageCollectionController: ASDKViewController<BaseNode> {
//
//    var vkApi = VKApi()
//    let realmService = RealmService.self
//    var friend: Friends?
//
//    lazy var friendPhotos: Results<UserPhotos>? = try? Realm(configuration: realmService.config).objects(UserPhotos.self).filter("owner_id == %@",friend?.id ?? 0)
//    var friendPhotosNotificationToken: NotificationToken?
//
//
//    var collectionNode: ASCollectionNode {
//        return node as! ASCollectionNode
//    }
//
//    var refreshControl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
//        refreshControl.tintColor = .green
//        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        return refreshControl
//    }()
//
//    @objc private func refresh() {
//        print(#function)
//        vkApi.vkphotosGet(owner_id: friend?.id ?? 0, completion: { [weak self] result in
//            switch result {
//            case let .failure(error):
//                Swift.print(error)
//            case let .success(friendPhotos):
//                do {
//                    try self?.realmService.save(items: friendPhotos)
//                } catch {
//                    Swift.print(error)
//                }
//            }
//        })
//        refreshControl.endRefreshing()
//    }
//
//    override init() {
//        let flowLayout = UICollectionViewFlowLayout()
////        self.collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
//        super.init(node: ASCollectionNode(collectionViewLayout: flowLayout))
//        flowLayout.minimumInteritemSpacing = 1
//        flowLayout.minimumLineSpacing = 1
//
//        collectionNode.dataSource = self
//        self.collectionNode.allowsSelection = false
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        vkApi.vkphotosGet(owner_id: friend?.id ?? 0, completion: { [weak self] result in
//            switch result {
//            case let .failure(error):
//                Swift.print(error)
//            case let .success(friendPhotos):
//                do {
//                    try self?.realmService.save(items: friendPhotos)
//                } catch {
//                    Swift.print(error)
//                }
//            }
//        })
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        friendPhotosNotificationToken = friendPhotos?.observe {changes in
//            switch changes {
//            case .initial:
//                print("Initial")
//                self.collectionNode.reloadData()
//            case let .update(_, deletions, insertions, modifications):
//                print(deletions, insertions, modifications)
//            //                self?.tableNode.view.applyNotificationToken(deletions: deletions, insertions: insertions, modifications: modifications)
//                self.collectionNode.reloadData()
//            case let  .error(error):
//                print(error)
//            }
//        }
//
//        title = friend?.name ?? "Empty"
//        print(friendPhotos?.count)
//
//        collectionNode.view.refreshControl = refreshControl
//    }
//
//}
//
////extension FriendsImageController: ASTableDelegate {
////
////    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
////        true
////    }
////
////}
//
////extension FriendsImageController: ASTableDataSource {
////
////    func numberOfSections(in tableNode: ASTableNode) -> Int {
////        return friendPhotos?.count ?? 0
////    }
////
////    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
////        return 1
////    }
////
////    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
////        guard let resource = friendPhotos?[indexPath.section] else {
////            preconditionFailure("News Cell cannot be dequeued")
////        }
////
////        guard let indexPath = resource.sizes.firstIndex(where: {$0.type == "m"}) else {
////            preconditionFailure("News Cell cannot get image")
////        }
////
////        let imageURL:String = resource.sizes[indexPath].url
////        let height: Int = resource.sizes[indexPath].height
////        let width: Int = resource.sizes[indexPath].width
////
//////        print("=====")
//////        print(imageURL)
//////        print(height)
//////        print(width)
//////        print("=====")
////
//////        return {FriendsImageNode(resource: resource)}
////        return {FriendsImageNode(resource: resource, imageURL: imageURL, height: height, width: width)}
////    }
////
////}
//
//extension FriendImageCollectionController: ASCollectionDataSource {
//    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
//        return 1
//    }
//
//    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
//        return friendPhotos?.count ?? 0
//    }
//
//    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
//        guard let resource = friendPhotos?[indexPath.section],
//              let indexPath = resource.sizes.firstIndex(where: {$0.type == "m"})  else {
//            preconditionFailure("News Cell cannot be dequeued")
//        }
//        
//        let imageURL:String = resource.sizes[indexPath].url
//        let height: Int = resource.sizes[indexPath].height
//        let width: Int = resource.sizes[indexPath].width
//
//        return {FriendsImageNode(resource: resource, imageURL: imageURL, height: height, width: width)}()
//    }
//
//}
