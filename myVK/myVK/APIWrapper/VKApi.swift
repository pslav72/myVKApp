//
//  VKApi.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.03.2021.
//

import Foundation
import Alamofire

class VKApi {
    
    let sessionsUserId = SessionsUser.shared.userId
    let sessionsToken = SessionsUser.shared.token
    
    let vkApiTarget = VKApiTarget()
    
    func vkFriendsGet() {
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .friendsGet)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "fields": "nickname,photo_50",
        ]
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }
        }
        
    }
        
        
    func vkUserGet() {
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .usersGet)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "fields": "photo_50",
        ]
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func vkGroupGet() {
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .groupGet)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
//            "fields": "photo_50",
        ]
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func vkGroupSearch(search: String = "") {
        
        guard search.count > 3 else {
            return
        }
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .groupsSearch)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "q": search,
        ]
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
