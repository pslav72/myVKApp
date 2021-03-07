//
//  News.swift
//  myVK
//
//  Created by Вячеслав Поляков on 06.03.2021.
//

import UIKit

struct News: Equatable {
    let user: String
    let userImage: UIImage?
    let dataCreateNews: String
    let header: String
    let image: UIImage?
    let photos: [NewsPhotos]
    let newsComment: [NewsComments]
}

struct NewsPhotos: Equatable {
    let image: UIImage?
    let description: String
    let like: Bool
    let countsLike: Int
}

struct NewsComments: Equatable {
    let comment: String
    let like: Bool
    let countsLike: Int
}

struct NewsSection: Comparable {
    static func < (lhs: NewsSection, rhs: NewsSection) -> Bool {
        lhs.title < rhs.title
    }
    
    let title: Character
    let news: [News]
}
