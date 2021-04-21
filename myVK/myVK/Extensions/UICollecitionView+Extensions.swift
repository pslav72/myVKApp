//
//  UICollecitionView+Extensions.swift
//  myVK
//
//  Created by Вячеслав Поляков on 20.04.2021.
//

import UIKit

extension UICollectionView {
    func applyNotificationToken(deletions: [Int] = [], insertions: [Int] = [], modifications: [Int] = []) {
        performBatchUpdates {
            let deletions = deletions.map { IndexPath(item: $0, section: 0)}
            deleteItems(at: deletions)
            let insertions = insertions.map { IndexPath(item: $0, section: 0)}
            insertItems(at: insertions)
            let modifications = modifications.map { IndexPath(item: $0, section: 0)}
            reloadItems(at: modifications)
        }
    }
}
