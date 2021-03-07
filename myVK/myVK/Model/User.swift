//
//  friends.swift
//  myVK
//
//  Created by Вячеслав Поляков on 19.02.2021.
//

import UIKit

struct User: Equatable {
    let name: String
    let image: UIImage?
    let photos: [UserPhotos]
}

struct UserPhotos: Equatable {
    let image: UIImage?
    let description: String
    let like: Bool
    let countsLike: Int
}

struct UserSection: Comparable {
    static func < (lhs: UserSection, rhs: UserSection) -> Bool {
        lhs.title < rhs.title
    }
    
    let title: Character
    let users: [User]
}
