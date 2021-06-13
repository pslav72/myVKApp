//
//  ImagePresentation.swift
//  myVK
//
//  Created by Вячеслав Поляков on 13.06.2021.
//

import AsyncDisplayKit
import RealmSwift

class ImagePresentation: BaseNode, ASTableDelegate {
    
    var vkApi = VKApi()
    let realmService = RealmService.self
    var friend: Friends?

    lazy var friendPhotos: Results<UserPhotos>? = try? Realm(configuration: realmService.config).objects(UserPhotos.self).filter("owner_id == %@",friend?.id ?? 0)
    var friendPhotosNotificationToken: NotificationToken?
    
    let table = ASTableNode()
    let dataSource = ImageDataSource()
    
    override init() {
        super.init()
        table.allowsSelection = false
        table.backgroundColor = .white
        table.dataSource = dataSource
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: table)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
    
}
