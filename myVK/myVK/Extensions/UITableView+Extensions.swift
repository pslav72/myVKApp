//
//  UITableView+Extensions.swift
//  myVK
//
//  Created by Вячеслав Поляков on 20.04.2021.
//

import UIKit

extension UITableView {
    func applyNotificationToken(deletions: [Int] = [], insertions: [Int] = [], modifications: [Int] = []) {
        performBatchUpdates {
            let deletions = deletions.map { IndexPath(item: $0, section: 0)}
            deleteRows(at: deletions, with: .automatic)
            let insertions = insertions.map { IndexPath(item: $0, section: 0)}
            insertRows(at: insertions, with: .automatic)
            let modifications = modifications.map { IndexPath(item: $0, section: 0)}
            reloadRows(at: modifications, with: .automatic)
        }
    }
}
