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
    case getProfileInfo
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.vk.com/method/")!
    }
    
    var path: String {
        switch self {
        case .getNewsFeed:
            return "newsfeed.get"
        case .getProfileInfo:
            return "account.getProfileInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNewsFeed, .getProfileInfo:
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
        guard let token = AuthorizationManager.shared.token else {return nil}
        
        params["lang"] = "ru"
        params["access_token"] = token
        params["v"] = version
        
        switch self {
        case .getNewsFeed:
            params["filters"] = "post"
        default:
            return params
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

