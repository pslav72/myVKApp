//
//  FriendsImageTableController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 08.06.2021.
//

import UIKit
import AsyncDisplayKit
import RealmSwift

class FriendsImageTableController: ASDKViewController<ASDisplayNode> {
    
    var vkApi = VKApi()
    let realmService = RealmService.self
    var friend: Friends?
    
    lazy var friendPhotos: Results<UserPhotos>? = try? Realm(configuration: realmService.config).objects(UserPhotos.self).filter("owner_id == %@",friend?.id ?? 0)
    var friendPhotosNotificationToken: NotificationToken?
    
    
    var tableNode: ASTableNode {
        return node as! ASTableNode
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
        // Инициализируемся с таблицей в качестве корневого View / Node
        super.init(node: ASTableNode())
        self.tableNode.backgroundColor = .white
        //        self.tableNode.delegate = self
        self.tableNode.dataSource = self
        // По желанию кастомизируем корневую таблицу
        self.tableNode.allowsSelection = false
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
                self.tableNode.reloadData()
            case let .update(_, deletions, insertions, modifications):
                print(deletions, insertions, modifications)
                //                self?.tableNode.view.applyNotificationToken(deletions: deletions, insertions: insertions, modifications: modifications)
                self.tableNode.reloadData()
            case let  .error(error):
                print(error)
            }
        }
        
        tableNode.view.refreshControl = refreshControl
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
//        backButton.setTitle("Back", for: .normal)
//        backButton.setTitleColor(backbutton.tintColor, for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
     @objc func backAction() {
        self.navigationController?.dismiss(animated: true)
    }
    
}

extension FriendsImageTableController: ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return friendPhotos?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let resource = friendPhotos?[indexPath.section],
              let indexPath = resource.sizes.firstIndex(where: {$0.type == "m"})  else {
            preconditionFailure("News Cell cannot be dequeued")
        }
        
        let imageURL:String = resource.sizes[indexPath].url
        let height: Int = resource.sizes[indexPath].height
        let width: Int = resource.sizes[indexPath].width
        
        return {FriendsImageNode(resource: resource, imageURL: imageURL, height: height, width: width)}
    }
    
    
    
}
