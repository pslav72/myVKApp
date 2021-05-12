//
//  friends.swift
//  myVK
//
//  Created by Вячеслав Поляков on 19.02.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

//struct Friends: Equatable {
//    let id: Int
//    let name: String
//    let image: String
//    let photo_50: String
//    let photo_100: String
//    var photoURL: URL? { URL(string: photo_100)}
//
//    init(json: SwiftyJSON.JSON) {
//        self.id = json["id"].int ?? 0
//        self.name = json["last_name"].string ?? ""
//        self.image = json["photo_50"].string ?? ""
//        self.photo_50 = json["photo_50"].string ?? ""
//        self.photo_100 = json["photo_100"].string ?? ""
//    }
//}
//
//struct UserPhotos {
//    let id: Int
//    let post_id: Int
//    let text: String
//    let likes: Likes
//    var sizes: [Sizes]
//
//
//    init(json: SwiftyJSON.JSON) {
//        self.id = json["id"].int ?? 0
//        self.post_id = json["post_id"].int ?? 0
//        self.text = json["text"].string ?? ""
//        let likesJson = json["likes"]
//        self.likes = Likes(json: likesJson)
//        self.sizes = json["sizes"].arrayValue.map(Sizes.init)
//
//    }
//}
//
//struct Sizes: Equatable {
//    let height: Int
//    let url: String
//    let type: String
//    let width: Int
//
//    init(json: SwiftyJSON.JSON) {
//        self.height = json["height"].int ?? 0
//        self.url = json["url"].string ?? ""
//        self.type = json["type"].string ?? ""
//        self.width = json["width"].int ?? 0
//    }
//}
//
//struct Likes {
//    let user_likes: Int
//    let count: Int
//
//    init(json: SwiftyJSON.JSON) {
//        self.user_likes = json["user_likes"].int ?? 0
//        self.count = json["count"].int ?? 0
//    }
//}

class Friends: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var photo_50: String = ""
    @objc dynamic var photo_100: String = ""
    @objc dynamic var photoURL: String = ""
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["last_name"].stringValue
        self.image = json["photo_50"].stringValue
        self.photo_50 = json["photo_50"].stringValue
        self.photo_100 = json["photo_100"].stringValue
        self.photoURL = self.photo_100
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class UserPhotos: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var owner_id: Int = 0
    @objc dynamic var post_id: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var likes: Likes?
    let sizes = List<Sizes>()

    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.owner_id = json["owner_id"].intValue
        self.post_id = json["post_id"].intValue
        self.text = json["text"].stringValue
        let likesJson = json["likes"]
        self.likes = Likes(json: likesJson)
        self.sizes.append(objectsIn: json["sizes"].arrayValue.map(Sizes.init))

    }
    
    override class func primaryKey() -> String? {
        return "id"
    }

}

class Sizes: EmbeddedObject {
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var width: Int = 0
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.height = json["height"].intValue
        self.url = json["url"].stringValue
        self.type = json["type"].stringValue
        self.width = json["width"].intValue
    }
}

class Likes: EmbeddedObject {
    @objc dynamic var user_likes: Int = 0
    @objc dynamic var count: Int = 0
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.user_likes = json["user_likes"].intValue
        self.count = json["count"].intValue
    }
}

struct UserSection: Comparable {
    static func < (lhs: UserSection, rhs: UserSection) -> Bool {
        lhs.title < rhs.title
    }
    
    let title: Character
    let users: [Friends]
}

struct FriendsSection: Comparable {
    static func < (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        lhs.title < rhs.title
    }
    
    let title: Character
    let friends: [Friends]
}
