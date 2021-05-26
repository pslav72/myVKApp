//
//  SaveParseOperation.swift
//  myVK
//
//  Created by Вячеслав Поляков on 25.05.2021.
//

import UIKit
import Realm

class SaveParseOperation: Operation {
    
//    let friends: [Friends]
    let realmService = RealmService.self
    
//    public init(friends: [Friends]) {
//        self.friends = friends
//    }
    
    override func main() {
        guard let friendsParseOperation = dependencies.first as? FriendsParseOperation,
              let friends = friendsParseOperation.parseData else {
            return
        }
        saveFriends(friends: friends)
    }
    
    fileprivate func saveFriends(friends: [Friends]) {
        do {
            try self.realmService.save(items: friends)
        } catch {
            print(error)
        }
    }
}
