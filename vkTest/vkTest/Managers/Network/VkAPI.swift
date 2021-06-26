//
//  VkAPI.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import Foundation
import Moya
import Alamofire

enum NetworkService {
    case getNewsFeed
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.vk.com/method/")!
    }
    
    var path: String {
        switch self {
        case .getNewsFeed:
            return "newsfeed.get"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNewsFeed:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        let version = AuthorizationManager.shared.versionAPI
        let token = AuthorizationManager.shared.token
//        guard let token = AuthorizationManager.shared.token?.accessToken else {return nil}
        switch self {
        case .getNewsFeed:
            params["lang"] = "ru"
            params["access_token"] = token
            params["v"] = version
//        default:
//            return nil
        }
        return params
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var task: Task {
        switch self {
        default:
            guard let params = parameters else {
                return .requestPlain
            }
            return .requestParameters(parameters: params, encoding: parameterEncoding)
        }
    }
}

