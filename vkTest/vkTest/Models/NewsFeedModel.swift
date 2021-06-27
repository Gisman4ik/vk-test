//
//  NewsFeedModel.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import Foundation
import ObjectMapper

class ResponseFeedWrapper: Mappable {
    
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
    
    var error = ""
    
    func mapping(map: Map) {
        error <- map["error_msg"]
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
}

class NewsFeedModel: Mappable {
    var items: [Item] = []
    var profiles: [Profile] = []
    var groups: [Group] = []
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        items       <- map["items"]
        profiles    <- map["profiles"]
        groups      <- map["groups"]
    }
}

class Item: Mappable {
    
    var sourceID = 0
    var postType = ""
    var text = ""
    var date = 0
    var attachments: [Attachment] = []
    var likes: Likes?
    var comments: Comments?
    var reposts: Reposts?
    var views: Views?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        sourceID        <- map["source_id"]
        postType        <- map["post_type"]
        text            <- map["text"]
        date            <- map["date"]
        attachments     <- map["attachments"]
        likes           <- map["likes"]
        comments        <- map["comments"]
        reposts         <- map["reposts"]
        views           <- map["views"]
    }
}

class Profile: Mappable, PostAuthor {
    
    var id = 0
    var firstName = ""
    var lastName = ""
    var photo100 = ""
    
    var name: String {
        "\(firstName) \(lastName)"
    }
    var photo: String {
        photo100
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        firstName   <- map["first_name"]
        lastName    <- map["last_name"]
        photo100     <- map["photo_100"]
    }
}

class Group: Mappable, PostAuthor {
    
    var id = 0
    var name = ""
    var photo100 = ""
    var photo: String {
        photo100
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        photo100     <- map["photo_100"]
    }
}

class Attachment: Mappable {
    
    var type = ""
    var photo: Photo?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        type        <- map["type"]
        photo       <- map["photo"]
    }
}

class Photo: Mappable {
    var id = 0
    var sizes: [PhotoSizes] = []
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        sizes   <- map["sizes"]
    }
}

class PhotoSizes: Mappable {
    
    var type = ""
    var url = ""
    var width = 0
    var height = 0
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        type    <- map["type"]
        url     <- map["url"]
        width   <- map["width"]
        height  <- map["height"]
    }
}

class Likes: Mappable {
    var count = 0
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        count      <- map["count"]
    }
}

class Comments: Mappable {
    var count = 0
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        count      <- map["count"]
    }
    
}

class Reposts: Mappable {
    var count = 0
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        count      <- map["count"]
    }
}

class Views: Mappable {
    var count = 0
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        count      <- map["count"]
    }
}

protocol PostAuthor {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}
