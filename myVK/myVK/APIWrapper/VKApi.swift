//
//  VKApi.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.03.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class VKApi {
    
    let sessionsUserId = SessionsUser.shared.userId
    let sessionsToken = SessionsUser.shared.token
    
    let vkApiTarget = VKApiTarget()
    
    var nextValue: String? = nil
    
    func vkFriendsGet(completion: @escaping (Swift.Result<[Friends], Error>) -> Void) {
        
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
                guard let data = data else { return }
                do {
                    let json = try JSON(data: data)
                    let friendsJSON = json["response"]["items"].arrayValue
                    let friends = friendsJSON.map { Friends(json: $0) }
                    completion(.success(friends))
                } catch {
                    completion(.failure(error))
                }
                
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
    
    
    func vkGroupGet(completion: @escaping (Swift.Result<[Group], Error>) -> Void) {
        
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
                guard let data = data else { return }
                do {
                    let json = try JSON(data: data)
                    let groupGetJSON = json["response"]["items"].arrayValue
                    let groupGet = groupGetJSON.map { Group(json: $0) }
                    completion(.success(groupGet))
                } catch  {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func vkGroupGet() -> Promise<[Group]> {
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .groupGet)
        
        let parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "extended": 1
        ]
        
        return Promise.init { resolver in
            Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
                switch response.result {
                case .failure(let error):
                    resolver.reject(error)
                case .success(let data):
                    guard let data = data else { return }
                    do {
                        let json = try JSON(data: data)
                        let groupGetJSON = json["response"]["items"].arrayValue
                        let groupGet = groupGetJSON.map { Group(json: $0) }
                        resolver.fulfill(groupGet)
                    } catch  {
                        resolver.reject(error)
                    }
                }
            }
        }
    }
    
    
    func vkGroupSearch(searchString: String = "", completion: @escaping (Swift.Result<[Group], Error>) -> Void) {
        
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
                guard let data = data else { return }
                do {
                    let json = try JSON(data: data)
                    let groupGetJSON = json["response"]["items"].arrayValue
                    let groupGet = groupGetJSON.map { Group(json: $0) }
                    completion(.success(groupGet))
                } catch {
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    
    func vkphotosGet(owner_id: Int = 0, album_id: String = "profile", completion: @escaping (Swift.Result<[UserPhotos], Error>) -> Void) {
        
        guard owner_id != 0 else {
            return
        }
        
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
                guard let data = data else { return }
                do {
                    let json = try JSON(data: data)
                    let userPhotosJSON = json["response"]["items"].arrayValue
                    let userPhotos = userPhotosJSON.map { UserPhotos(json: $0) }
                    completion(.success(userPhotos))
                } catch {
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    func vkNewsFeed(startTime: Int? = nil, nextFrom: String? = nil, completion: @escaping (Swift.Result<JSON, Error>) -> Void) {
        
        let scheme = vkApiTarget.scheme
        let host = vkApiTarget.host
        let path = vkApiTarget.pathMethod(method: .newsFeed)
        
        var parameters: Parameters = [
            "access_token": sessionsToken,
            "v": vkApiTarget.apiVersion,
            "filters": "friend,post",
            "max_photos": "1",
            "count": "10"
        ]
        
        if let startTime = startTime {
            parameters["start_time"] = String(startTime)
        }
        
        if let nextFrom = nextFrom {
            parameters["start_from"] = nextFrom
        }
        
        Alamofire.AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
            case .success (let data):
                guard let data = data else { return }
                do {
                    let json = try JSON(data: data)
//                    let newsFeedJSON = json["response"]["items"].arrayValue
//                    let newsGroupsJSON = json["response"]["groups"].arrayValue
//                    let newsProfilesJSON = json["response"]["profiles"].arrayValue
//                    let newsFeed = newsFeedJSON.map { NewsFeed(json: $0) }
//                    let newsGroups = newsGroupsJSON.map { NewsFeed(json: $0) }
//                    let newsProfiles = newsProfilesJSON.map { NewsFeed(json: $0) }
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
                
            }
        }
        
    }

    
    
}
