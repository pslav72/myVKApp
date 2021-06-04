//
//  News.swift
//  myVK
//
//  Created by Вячеслав Поляков on 06.03.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

//struct News: Equatable {
//    let user: String
//    let userImage: UIImage?
//    let dataCreateNews: String
//    let header: String
//    let image: UIImage?
//    let photos: [NewsPhotos]
//    let newsComment: [NewsComments]
//}
//
//struct NewsPhotos: Equatable {
//    let image: UIImage?
//    let description: String
//    let like: Bool
//    let countsLike: Int
//}
//
//struct NewsComments: Equatable {
//    let comment: String
//    let like: Bool
//    let countsLike: Int
//}
//
//struct NewsSection: Comparable {
//    static func < (lhs: NewsSection, rhs: NewsSection) -> Bool {
//        lhs.title < rhs.title
//    }
//    
//    let title: Character
//    let news: [News]
//}

class NewsFeed: Object {
    @objc dynamic var post_id: Int = 0
    @objc dynamic var source_id: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var can_doubt_category: Bool = false
    @objc dynamic var can_set_category: Bool = false
    @objc dynamic var post_type: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var marked_as_ads: Int8 = 0
    let attachments = List<Attachments>()
    
    @objc dynamic var comments: Comments?
    @objc dynamic var likes: Likes?
    @objc dynamic var reposts: Reposts?
    @objc dynamic var views: Views?
    
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.post_id = json["post_id"].intValue
        self.source_id = json["source_id"].intValue
        self.date = json["date"].intValue
        self.can_doubt_category = json["can_doubt_category"].boolValue
        self.can_set_category = json["can_set_category"].boolValue
        self.post_type = json["post_type"].stringValue
        self.text = json["text"].stringValue
        self.marked_as_ads = json["is_advertiser"].int8Value
        self.attachments.append(objectsIn: json["attachments"].arrayValue.map(Attachments.init))
        
//        let photoJson = json["photo"]
        self.comments = Comments(json: json["comments"])
        self.likes = Likes(json: json["likes"])
        self.reposts = Reposts(json: json["reposts"])
        self.views = Views(json: json["views"])
    }
    
    override class func primaryKey() -> String? {
        return "post_id"
    }
}

class Attachments: EmbeddedObject {
    @objc dynamic var type: String = ""
    @objc dynamic var photo: Photo?
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.type = json["type"].stringValue
        let photoJson = json["photo"]
        self.photo = Photo(json: photoJson)
    }
}

class Photo: EmbeddedObject {
    @objc dynamic var album_id: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var owner_id: Int = 0
    @objc dynamic var has_tags: Bool = false
    @objc dynamic var access_key: String = ""
    let sizes = List<Sizes>()
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.album_id = json["album_id"].intValue
        self.date = json["date"].intValue
        self.id = json["id"].intValue
        self.owner_id = json["owner_id"].intValue
        self.has_tags = json["has_tags"].boolValue
        self.access_key = json["access_key"].stringValue
        self.sizes.append(objectsIn: json["sizes"].arrayValue.map(Sizes.init))

    }
}

class Comments: EmbeddedObject {
    @objc dynamic var count: Int = 0
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.count = json["count"].intValue
    }
}

class Reposts: EmbeddedObject {
    @objc dynamic var count: Int = 0
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.count = json["count"].intValue
    }
}

class Views: EmbeddedObject {
    @objc dynamic var count: Int = 0
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.count = json["count"].intValue
    }
}

class NewsProfiles: Object {
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

class NewsGroup: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screen_name: String = ""
    @objc dynamic var is_closed: Int8 = 0
    @objc dynamic var type: String = ""
    @objc dynamic var is_admin: Int8 = 0
    @objc dynamic var is_member: Int8 = 0
    @objc dynamic var is_advertiser: Int8 = 0
    @objc dynamic var photo_50: String = ""
    @objc dynamic var photo_100: String = ""
    @objc dynamic var photo_200: String = ""
    
    @objc dynamic var image: String = ""
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()

        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.screen_name = json["screen_name"].stringValue
        self.is_closed = json["is_closed"].int8Value
        self.type = json["type"].stringValue
        self.is_admin = json["is_admin"].int8Value
        self.is_member = json["is_member"].int8Value
        self.is_advertiser = json["is_advertiser"].int8Value
        self.photo_50 = json["photo_50"].stringValue
        self.photo_100 = json["photo_100"].stringValue
        self.photo_200 = json["photo_200"].stringValue
        self.image = self.photo_100
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}


//class Sizes: EmbeddedObject {
//    @objc dynamic var height: Int = 0
//    @objc dynamic var url: String = ""
//    @objc dynamic var type: String = ""
//    @objc dynamic var width: Int = 0
//
//    convenience init(json: SwiftyJSON.JSON) {
//        self.init()
//
//        self.height = json["height"].intValue
//        self.url = json["url"].stringValue
//        self.type = json["type"].stringValue
//        self.width = json["width"].intValue
//    }
//}
