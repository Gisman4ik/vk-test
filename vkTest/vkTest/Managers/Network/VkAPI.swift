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
    case getProfilePhoto
    case getUserInfo(id: Int?)
    case getUserFriends(id: Int?)
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.vk.com/method/")!
    }
    
    var path: String {
        switch self {
        case .getNewsFeed:
            return "newsfeed.get"
        case .getUserInfo:
            return "users.get"
        case .getProfilePhoto:
            return "photos.get"
        case .getUserFriends:
            return "friends.get"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
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
        case .getProfilePhoto:
            params["album_id"] = "profile"
        case .getUserInfo(id: let id):
            params["user_id"] = id
            params["fields"] = "photo_max_orig, online, domain, site, education, status, last_seen, followers_count, occupation, relation, sex, bdate, city, country, home_town, screen_name, photo_max"
        case .getUserFriends(id: let id):
            params["user_id"] = id
            params["fields"] = "photo_max"
            params["order"] = "hints"
//        default:
//            return params
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
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
}
