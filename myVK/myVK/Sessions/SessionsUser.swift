//
//  SessionsUser.swift
//  myVK
//
//  Created by Вячеслав Поляков on 21.03.2021.
//

import Foundation

class SessionsUser {
    
    var token: String = ""
    var userId: String = ""
    
    private init () {}
    
    static let shared = SessionsUser()
}
