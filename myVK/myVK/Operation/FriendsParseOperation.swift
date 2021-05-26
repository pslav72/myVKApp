//
//  FriendsParseOperation.swift
//  myVK
//
//  Created by Вячеслав Поляков on 24.05.2021.
//

import UIKit
import SwiftyJSON

class FriendsParseOperation: Operation {
    
//    let data: Data
    private(set) var parseData: [Friends]?
    
//    public init(data: Data) {
//        self.data = data
//    }
//
    override func main() {
        guard let friendsLoadingOperation = dependencies.first as? FriendsLoadingOperation,
              let dataParse = friendsLoadingOperation.outputData else {
            return
        }
        parseFriends(data: dataParse)
    }
    
    fileprivate func parseFriends(data: Data) {
        do {
            let json = try JSON(data: data)
            let friendsJSON = json["response"]["items"].arrayValue
            let friends = friendsJSON.map { Friends(json: $0) }
            parseData = friends
        } catch{
            print(error)
        }
    }
}
