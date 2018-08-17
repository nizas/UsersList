//
//  DatabaseManager.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/14/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    
    class func save(user: Users, handler: (() -> ())?) {
        
        let realm = try! Realm()
        
        if user.id == 0 {
            let maxId: Int? = realm.objects(Users.self).max(ofProperty: "id")
            if let id = maxId {
                user.id = id + 1
            } else {
                user.id = 1
            }
        }
        
        try! realm.write {
            realm.add(user, update: true)
            handler?()
        }
    }
    
    class func getUsers() -> [Users] {
        
        let realm = try! Realm()
        return realm.objects(Users.self).toArray(ofType: Users.self)
    }
    
    class func delete(user: Users, handler: (() -> ())?) {

        let realm = try! Realm()
        try! realm.write {
            realm.delete(user)
            handler?()
        }
    }
}
