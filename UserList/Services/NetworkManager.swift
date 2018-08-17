//
//  NetworkManager.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/14/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import Foundation
import Alamofire

class InternalResponse<T: Codable>: Codable {
    var results: T?
}

class NetworkManager {
    
    static let baseUrl = "https://randomuser.me/api/"
    
    class func commonRequest<T>(_ type: T.Type, method: HTTPMethod = .get, parameters: Parameters, onReceive: @escaping ((InternalResponse<T>?, Error?) -> Void)) {
 
        Alamofire.request(NetworkManager.baseUrl, method: method, parameters: parameters, encoding: URLEncoding.default).responseData { (response) in
            guard let value = response.result.value else { return }
            do {
                let item = try JSONDecoder().decode(InternalResponse<T>.self, from: value)
                onReceive(item, nil)
            } catch {
                print(error)
                onReceive(nil, error)
            }
        }
    }
    
    class func downloadImageFrom(url: String, handler: @escaping (Data?, Error?) -> ())  {
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
            if let responseData = response.data {
                handler(responseData, nil)
            } else {
                handler(nil, response.error)
            }
        })
    }
}


