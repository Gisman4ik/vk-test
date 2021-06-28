//
//  FriendsModel.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import Foundation
import ObjectMapper

class ResponseFriendsWrapper: Mappable {
    
    var response: FriendsModel?
    var error: Error?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        error    <- map["error"]
    }
}

class FriendsModel: Mappable {
    
    var count = 0
    var friends: [UserModel] = []
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        count       <- map["count"]
        friends     <- map["items"]
    }
}
