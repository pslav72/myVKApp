//
//  VKApiTarget.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.03.2021.
//

import Foundation

class VKApiTarget {
    
    let scheme: String = "https://"
    let schemeWebView: String = "https"
    let host: String = "api.vk.com"
    let oauthHost: String = "oauth.vk.com"
    let apiVersion: String = "5.130"
    
    enum listsMethod: String {
        case friendsGet
        case usersGet
        case groupGet
        case groupsSearch
        case authorize
        case photosGet
        case newsFeed
    }
    
    func pathMethod(method: listsMethod) -> String {
        switch method {
        case .friendsGet:
            return "/method/friends.get"
        case .usersGet:
            return "/method/users.get"
        case .groupGet:
            return "/method/groups.get"
        case .groupsSearch:
            return "/method/groups.search"
        case .authorize:
            return "/authorize"
        case .photosGet:
            return "/method/photos.get"
        case .newsFeed:
            return "/method/newsfeed.get"
        }
    }
}
