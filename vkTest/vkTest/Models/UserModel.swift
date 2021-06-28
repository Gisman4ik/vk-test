//
//  UserModel.swift
//  vkTest
//
//  Created by Artur Radziukhin on 28.06.21.
//

import Foundation
import ObjectMapper

class ResponseUserWrapper: Mappable {
    
    var response: [UserModel]?
    var error: Error?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        error    <- map["error"]
    }
}

class UserModel: Mappable {
    
    var firstName = ""
    var id = 0
    var lastName = ""
    var homeTown = ""
    var status = ""
    var bdate = ""
    var city: City?
    var country: Country?
    var phone = ""
    var relation = 0
    var screenName = ""
    var sex = 0
    var occupation: Occupation?
    var online = 0
    var photoMax = ""
    var photo200Orig = ""
    var followersCount = 0
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        firstName       <- map["first_name"]
        id              <- map["id"]
        lastName        <- map["last_name"]
        homeTown        <- map["home_town"]
        status          <- map["status"]
        bdate           <- map["bdate"]
        city            <- map["city"]
        country         <- map["country"]
        phone           <- map["phone"]
        relation        <- map["relation"]
        screenName      <- map["screen_name"]
        sex             <- map["sex"]
        occupation      <- map["occupation"]
        online          <- map["online"]
        photoMax    <- map["photo_max"]
        photo200Orig    <- map["photo_200_orig"]
        followersCount  <- map["followers_count"]
    }
}

class City: Mappable {
    
    var id = 0
    var title = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["title"]
    }
}

class Country: Mappable {
    
    var id = 0
    var title = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["title"]
    }
}

class Occupation: Mappable {
    
    var name = ""
    var type = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        type <- map["type"]
    }
}
