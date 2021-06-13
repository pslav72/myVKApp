//
//  FriendsImageCollectionController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 08.06.2021.
//

import UIKit
import AsyncDisplayKit
import RealmSwift

class FriendsImageCollectionController: ASDKViewController<ASDisplayNode> {
    
    var vkApi = VKApi()
    let realmService = RealmService.self
    var friend: Friends?
    
    lazy var friendPhotos: Results<UserPhotos>? = try? Realm(configuration: realmService.config).objects(UserPhotos.self).filter("owner_id == %@",friend?.id ?? 0)
    var friendPhotosNotificationToken: NotificationToken?
    
    
    var collecionNode: ASCollectionNode {
        return node as! ASCollectionNode
    }
    
    
    var imagePresentation: ImagePresentation?
    
    var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.tintColor = .green
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func refresh() {
        print(#function)
        vkApi.vkphotosGet(owner_id: friend?.id ?? 0, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                Swift.print(error)
            case let .success(friendPhotos):
                do {
                    try self?.realmService.save(items: friendPhotos)
                } catch {
                    Swift.print(error)
                }
            }
        })
        refreshControl.endRefreshing()
    }
    
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        self.collecionNode.backgroundColor = .white
        //        self.tableNode.delegate = self
        self.collecionNode.dataSource = self
        // По желанию кастомизируем корневую таблицу
        self.collecionNode.allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        vkApi.vkphotosGet(owner_id: friend?.id ?? 0, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                Swift.print(error)
            case let .success(friendPhotos):
                do {
                    try self?.realmService.save(items: friendPhotos)
                } catch {
                    Swift.print(error)
                }
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendPhotosNotificationToken = friendPhotos?.observe {changes in
            switch changes {
            case .initial:
                print("Initial")
                self.collecionNode.reloadData()
            case let .update(_, deletions, insertions, modifications):
                print(deletions, insertions, modifications)
                //                self?.tableNode.view.applyNotificationToken(deletions: deletions, insertions: insertions, modifications: modifications)
                self.collecionNode.reloadData()
            case let  .error(error):
                print(error)
            }
        }
        
        collecionNode.view.refreshControl = refreshControl
//
//        let backButton = UIButton(type: .custom)
//        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
//        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backAction))
        
        if let friendName = friend?.name {
            navigationItem.title = String(friendName)
        }
        
        //MARK: - На будущую релизацию переходов
        
        //                self.navigationItem.leftItemsSupplementBackButton = true
        //                navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        //
        //        if let topItem = self.navigationController?.navigationBar.topItem {
        //           topItem.backBarButtonItem = UIBarButtonItem(title: "ass", style: .plain, target: self, action: #selector(backAction))
        //        }
        
    }
    
     @objc func backAction() {
        print("Back")
        self.navigationController?.dismiss(animated: true)
    }
    
}

extension FriendsImageCollectionController: ASCollectionDataSource {
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return friendPhotos?.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let resource = friendPhotos?[indexPath.section],
              let indexPath = resource.sizes.firstIndex(where: {$0.type == "x"})  else {
            preconditionFailure("News Cell cannot be dequeued")
        }
        
        let imageURL:String = resource.sizes[indexPath].url
        let height: Int = resource.sizes[indexPath].height
        let width: Int = resource.sizes[indexPath].width
        
        return {FriendsImageNode(resource: resource, imageURL: imageURL, height: height, width: width)}
    }
    
    
}
