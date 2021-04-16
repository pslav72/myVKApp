//
//  Group.swift
//  myVK
//
//  Created by Вячеслав Поляков on 20.02.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

struct GroupT: Equatable {
    let name: String
    let image: UIImage?
}

//struct Group: Equatable {
//    let id: Int
//    let name: String
//    let screen_name: String
//    let is_closed: Int
//    let type: String
//    let is_admin: Int
//    let is_member: Int
//    let is_advertiser: Int
//    let photo_50: URL?
//    let photo_100: URL?
//    let photo_200: URL?
//
//    var image: URL? {photo_100}
//
//
//    init(json: SwiftyJSON.JSON) {
//        self.id = json["id"].int ?? 0
//        self.name = json["name"].string ?? ""
//        self.screen_name = json["screen_name"].string ?? ""
//        self.is_closed = json["is_closed"].int ?? 0
//        self.type = json["type"].string ?? ""
//        self.is_admin = json["is_admin"].int ?? 0
//        self.is_member = json["is_member"].int ?? 0
//        self.is_advertiser = json["is_advertiser"].int ?? 0
//        self.photo_50 = URL(string: json["photo_50"].string ?? "")
//        self.photo_100 = URL(string: json["photo_100"].string ?? "")
//        self.photo_200 = URL(string: json["photo_200"].string ?? "")
//    }

class Group: Object {
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
    
}
