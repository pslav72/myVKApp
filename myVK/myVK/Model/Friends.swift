//
//  friends.swift
//  myVK
//
//  Created by Вячеслав Поляков on 19.02.2021.
//

import UIKit
import SwiftyJSON

struct Friends: Equatable {
    let id: Int
    let name: String
    let image: String
    let photo_50: String
    let photo_100: String
    var photoURL: URL? { URL(string: photo_100)}
    
    init(json: SwiftyJSON.JSON) {
        self.id = json["id"].int ?? 0
        self.name = json["last_name"].string ?? ""
        self.image = json["photo_50"].string ?? ""
        self.photo_50 = json["photo_50"].string ?? ""
        self.photo_100 = json["photo_100"].string ?? ""
    }
}

struct UserPhotos {
    let id: Int
    let post_id: Int
    let text: String
    let likes: Likes
    var sizes: [Sizes]

    
    init(json: SwiftyJSON.JSON) {
        self.id = json["id"].int ?? 0
        self.post_id = json["post_id"].int ?? 0
        self.text = json["text"].string ?? ""
        let likesJson = json["likes"]
        self.likes = Likes(json: likesJson)
        self.sizes = json["sizes"].arrayValue.map(Sizes.init)

    }
}

struct Sizes: Equatable {
    let height: Int
    let url: String
    let type: String
    let width: Int
    
    init(json: SwiftyJSON.JSON) {
        self.height = json["height"].int ?? 0
        self.url = json["url"].string ?? ""
        self.type = json["type"].string ?? ""
        self.width = json["width"].int ?? 0
    }
}

struct Likes {
    let user_likes: Int
    let count: Int
    
    init(json: SwiftyJSON.JSON) {
        self.user_likes = json["user_likes"].int ?? 0
        self.count = json["count"].int ?? 0
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
