//
//  NetworkManager.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import Foundation
import Moya
import Moya_ObjectMapper

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    
    func getNewsFeed(completion: @escaping (ResponseFeedWrapper) -> Void, failure: @escaping (String) -> Void) {
        provider.request(.getNewsFeed) { (result) in
            switch result {
            case let .success(response):
                guard let responseWrapper = try? response.mapObject(ResponseFeedWrapper.self) else {
                    failure("Unknown")
                    return
                }
                completion(responseWrapper)
            case let .failure(error):
                failure(error.errorDescription ?? "Unknown")
            }
        }
    }
    
    func getUserInfo(completion: @escaping (ResponseUserWrapper) -> Void, failure: @escaping (String) -> Void) {
        provider.request(.getUserInfo) { (result) in
            switch result {
            case let .success(response):
                guard let responseWrapper = try? response.mapObject(ResponseUserWrapper.self) else {
                    failure("Unknown")
                    return
                }
                completion(responseWrapper)
            case let .failure(error):
                failure(error.errorDescription ?? "Unknown")
            }
        }
    }
    
   func getProfilePhoto(completion: @escaping (ResponseUserPhotoWrapper) -> Void, failure: @escaping (String) -> Void) {
        provider.request(.getProfilePhoto) { (result) in
            switch result {
            case let .success(response):
                guard let responseWrapper = try? response.mapObject(ResponseUserPhotoWrapper.self) else {
                    failure("Unknown")
                    return
                }
                completion(responseWrapper)
            case let .failure(error):
                failure(error.errorDescription ?? "Unknown")
            }
        }
    }
}
