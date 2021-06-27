//
//  RealmManager.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    private init() {}

    let realm = try! Realm()
    
    func saveToken(token: RealmTokenSaver) {
        try! realm.write {
            realm.add(token)
        }
    }
    
    func readToken() -> String? {
        try! realm.write {
            let token = realm.objects(RealmTokenSaver.self).first?.token
            return token
        }
    }
    
    func updateToken(token: RealmTokenSaver) {
        try! realm.write {
            realm.delete(realm.objects(RealmTokenSaver.self))
        }
        saveToken(token: token)
    }
}
