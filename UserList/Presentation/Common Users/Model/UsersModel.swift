//
//  UsersModel.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/14/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
final class Users: Object, Codable {
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    dynamic public var name: Name?
    dynamic public var email: String?
    dynamic public var phone: String?
    dynamic public var picture: Picture?
    dynamic public var profileImage: Data?
    dynamic public var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case phone = "phone"
        case picture = "picture"
    }
}

@objcMembers
final class Name: Object, Codable {
    dynamic public var title: String?
    dynamic public var first: String?
    dynamic public var last: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }
}

@objcMembers
final class Picture: Object, Codable {
    dynamic public var large: String?
    dynamic public var medium: String?
    dynamic public var thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }
}

