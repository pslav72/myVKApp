//
//  sessionsUser.swift
//  myVK
//
//  Created by Вячеслав Поляков on 21.03.2021.
//

import Foundation

class sessionsUser {
    
    var token: String = ""
    var userId: Int = 0
    
    private init () {}
    
    static let instance = sessionsUser()
}
