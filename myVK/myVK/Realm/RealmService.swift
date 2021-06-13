//
//  RealmService.swift
//  myVK
//
//  Created by Вячеслав Поляков on 14.04.2021.
//

import Foundation
import RealmSwift

class RealmService {
    static let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(items: [T],
                                configuration: Realm.Configuration = config,
                                update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write{
            realm.add(items, update: update)
        }
    }
    
    static func save<T: Object>(items: T,
                                configuration: Realm.Configuration = config,
                                update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write{
            realm.add(items, update: update)
        }
    }
    
    static func delete<T: Object>(items: T,
                                configuration: Realm.Configuration = config,
                                update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
//        print(configuration.fileURL ?? "")
        try realm.write{
            realm.delete(items)
        }
    }
    
}
