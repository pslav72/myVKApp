//
//  Group.swift
//  myVK
//
//  Created by Вячеслав Поляков on 20.02.2021.
//

import UIKit
import SwiftyJSON

struct GroupT: Equatable {
    let name: String
    let image: UIImage?
}

struct Group: Equatable {
    let id: Int
    let name: String
    let screen_name: String
    let is_closed: Int
    let type: String
    let is_admin: Int
    let is_member: Int
    let is_advertiser: Int
    let photo_50: URL?
    let photo_100: URL?
    let photo_200: URL?
    
    var image: URL? {photo_100}

    
    init(json: SwiftyJSON.JSON) {
        self.id = json["id"].int ?? 0
        self.name = json["name"].string ?? ""
        self.screen_name = json["screen_name"].string ?? ""
        self.is_closed = json["is_closed"].int ?? 0
        self.type = json["type"].string ?? ""
        self.is_admin = json["is_admin"].int ?? 0
        self.is_member = json["is_member"].int ?? 0
        self.is_advertiser = json["is_advertiser"].int ?? 0
        self.photo_50 = URL(string: json["photo_50"].string ?? "")
        self.photo_100 = URL(string: json["photo_100"].string ?? "")
        self.photo_200 = URL(string: json["photo_200"].string ?? "")
    }
}
