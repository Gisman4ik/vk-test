//
//  ProfileModel.swift
//  vkTest
//
//  Created by Artur Radziukhin on 27.06.21.
//

import Foundation
import ObjectMapper

class ResponseProfileWrapper: Mappable {
    
    var response: ProfileModel?
    var error: Error?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        error    <- map["error"]
    }
}

class ProfileModel: Mappable {
    
    var firstName = ""
    var id = 0
    var lastName = ""
    var homeTown = ""
    var status = ""
    var bdate = ""
    var bdateVisibility = 0
    var city: City?
    var country: Country?
    var phone = ""
    var relation = 0
    var screenName = ""
    var sex = 0
    
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
        bdateVisibility <- map["bdate_visibility"]
        city            <- map["city"]
        country         <- map["country"]
        phone           <- map["phone"]
        relation        <- map["relation"]
        screenName      <- map["screen_name"]
        sex             <- map["sex"]
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
