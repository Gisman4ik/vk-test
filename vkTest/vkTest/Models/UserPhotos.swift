//
//  UserPhotos.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import Foundation
import ObjectMapper

class ResponseUserPhotoWrapper: Mappable {
    
    var response: UserPhotos?
    var error: Error?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        error    <- map["error"]
    }
}

class UserPhotos: Mappable {
    
    var items: [Photo]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        items   <- map["items"]
    }
}
