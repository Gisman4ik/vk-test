//
//  RealmTokenSaver.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import Foundation
import RealmSwift

class RealmTokenSaver: Object {
    
    @objc dynamic var token = ""
    
   convenience init(token: String) {
        self.init()
        self.token = token
    }
}
