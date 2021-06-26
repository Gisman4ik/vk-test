//
//  NewsFeedModel.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import Foundation
import ObjectMapper

class ResponseWrapper: Mappable {
    
    var response: NewsFeedModel?
    var error: Error?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        error    <- map["error"]
    }
}

class Error: Mappable {
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
}

class NewsFeedModel: Mappable {
    var items: [Items] = []
    var profiles: [Profiles] = []
    var groups: [Groups] = []
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        items       <- map["items"]
        profiles    <- map["profiles"]
        groups      <- map["groups"]
    }
}

class Items: Mappable {
    
    var sourceID = 0
    var postType = ""
    var text = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        sourceID        <- map["source_id"]
        postType        <- map["post_type"]
        text            <- map["text"]
    }
}

class Profiles: Mappable {
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
    }
}

class Groups: Mappable {
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
    }
}
