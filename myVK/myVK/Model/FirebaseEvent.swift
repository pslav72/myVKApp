//
//  FirebaseEvent.swift
//  myVK
//
//  Created by Вячеслав Поляков on 24.04.2021.
//

import Foundation
import FirebaseDatabase

struct FirebaseEvent {
    var id: Int
    var event: String
    
    let ref: DatabaseReference?
    
    init(id: Int, event: String) {
        self.id = id
        self.event = event
        
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard let value = snapshot.value as? [String: Any],
        let id = value["id"] as? Int,
        let event = value["event"] as? String
        
        else { return nil }

        self.id = id
        self.event = event
        
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        [
            "id": id,
            "event": event
        ]
    }
}

