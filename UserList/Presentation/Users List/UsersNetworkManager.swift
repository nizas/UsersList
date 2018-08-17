//
//  UsersNetworkManager.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/16/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    class func getUsers(page: Int, result: Int, onReceive: @escaping (InternalResponse<[Users]>?, Error?) -> Void) {
        let parameters: [String: Any] = ["inc": "name, email, phone, picture", "results": result, "page": page]
        self.commonRequest([Users].self, parameters: parameters, onReceive: onReceive)
    }
}
