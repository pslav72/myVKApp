//
//  FriendsLoadingOperation.swift
//  myVK
//
//  Created by Вячеслав Поляков on 24.05.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class FriendsLoadingOperation: AsyncOperation {
    
    let sessionsUserId = SessionsUser.shared.userId
    let sessionsToken = SessionsUser.shared.token
   
    let vkApi = VKApi()
    let vkApiTarget = VKApiTarget()
    
    private(set) var outputData: Data?

    override func main() {
        loadFriends(completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                self?.outputData = friends
            }
            self?.state = .finished
        })
       
    }
    
    fileprivate func loadFriends(completion: @escaping (Result<Data, Error>) -> Void) {
        
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
                completion(.success(data))
            }
        }
    }
    
}
