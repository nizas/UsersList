//
//  ApplicationRouter.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/16/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import UIKit

class ApplicationRouter {
    
    class func showEditUser() -> EditUserTVC {
        let storyboard = UIStoryboard.init(name: "EditUser", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "kEditUser") as! EditUserTVC
        return destination
    }
}
