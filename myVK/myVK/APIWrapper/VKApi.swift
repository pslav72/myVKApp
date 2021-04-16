//
//  VKApi.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.03.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class VKApi {
    
    let sessionsUserId = SessionsUser.shared.userId
    let sessionsToken = SessionsUser.shared.token
    
    let vkApiTarget = VKApiTarget()
    
    func vkFriendsGet(completion: @escaping (Result<[Friends], Error>) -> Void) {
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .friendsGet)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "fields": "nickname,photo_50,photo_100",
        ]
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
            case .success (let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let friendsJSON = json["response"]["items"].arrayValue
                let friends = friendsJSON.map { Friends(json: $0) }
                completion(.success(friends))
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
    
    
    func vkGroupGet(completion: @escaping (Result<[Group], Error>) -> Void) {
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .groupGet)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "extended": 1
        ]
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let groupGetJSON = json["response"]["items"].arrayValue
                let groupGet = groupGetJSON.map { Group(json: $0) }
                completion(.success(groupGet))
            }
        }
    }
    
    
    func vkGroupSearch(searchString: String = "", completion: @escaping (Result<[Group], Error>) -> Void) {
        
        guard searchString.count > 3 else {
            return
        }
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .groupsSearch)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "q": searchString,
            "extended": 1
        ]
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let groupGetJSON = json["response"]["items"].arrayValue
                let groupGet = groupGetJSON.map { Group(json: $0) }
                completion(.success(groupGet))
            }
        }
    }
    
    
    func vkphotosGet(owner_id: Int = 0, album_id: String = "profile", completion: @escaping (Result<[UserPhotos], Error>) -> Void) {
        
        guard owner_id != 0 else {
            return
        }
        
//        print(#function)
//        print(owner_id, album_id)
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .photosGet)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "owner_id": owner_id,
            "album_id": album_id,
            "extended": 1
        ]
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
            case .success (let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let userPhotosJSON = json["response"]["items"].arrayValue
//                let userPhotosSizesJSON = json["response"]["items"].arrayValue.map{$0["sizes"].arrayValue}
                let userPhotos = userPhotosJSON.map { UserPhotos(json: $0) }
//
//                print("-------------")
//                print(userPhotosSizesJSON)
//                print("-------------")
                completion(.success(userPhotos))
            }
        }
    }
    
    
}
