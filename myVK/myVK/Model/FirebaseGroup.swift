//
//  FirebaseGroup.swift
//  myVK
//
//  Created by Вячеслав Поляков on 24.04.2021.
//

import Foundation
import FirebaseDatabase

struct FirebaseGroup: Equatable {
    var id: Int
    var name: String
    var screen_name: String
    var is_closed: Int8
    var type: String
    var is_admin: Int8
    var is_member: Int8
    var is_advertiser: Int8
    var photo_50: String
    var photo_100: String
    var photo_200: String
    var image: String
    
    let ref: DatabaseReference?
    
    init(id: Int, name: String, screen_name: String,
         is_closed: Int8, type: String, is_admin: Int8, is_member: Int8,
         is_advertiser: Int8, photo_50: String, photo_100: String,
         photo_200: String, image: String) {
        self.id = id
        self.name = name
        self.screen_name = screen_name
        self.is_closed = is_closed
        self.type = type
        self.is_admin = is_admin
        self.is_member = is_member
        self.is_advertiser = is_advertiser
        self.photo_50 = photo_50
        self.photo_100 = photo_100
        self.photo_200 = photo_200
        self.image = image
        
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard let value = snapshot.value as? [String: Any],
        let id = value["id"] as? Int,
        let name = value["name"] as? String,
        let screen_name = value["screen_name"] as? String,
        let is_closed = value["is_closed"] as? Int8,
        let type = value["type"] as? String,
        let is_admin = value["is_admin"] as? Int8,
        let is_member = value["is_member"] as? Int8,
        let is_advertiser = value["is_advertiser"] as? Int8,
        let photo_50 = value["photo_50"] as? String,
        let photo_100 = value["photo_100"] as? String,
        let photo_200 = value["photo_200"] as? String,
        let image = value["image"] as? String
        
        else { return nil }

        self.id = id
        self.name = name
        self.screen_name = screen_name
        self.is_closed = is_closed
        self.type = type
        self.is_admin = is_admin
        self.is_member = is_member
        self.is_advertiser = is_advertiser
        self.photo_50 = photo_50
        self.photo_100 = photo_100
        self.photo_200 = photo_200
        self.image = image
        
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        [
            "id": id,
            "name": name,
            "screen_name":  screen_name,
            "is_closed": is_closed,
            "type": type,
            "is_admin": is_admin,
            "is_member": is_member,
            "is_advertiser": is_advertiser,
            "photo_50": photo_50,
            "photo_100": photo_100,
            "photo_200": photo_200,
            "image": image
        ]
    }
}

