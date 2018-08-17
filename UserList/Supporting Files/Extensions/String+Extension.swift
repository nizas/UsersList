//
//  String+Extension.swift
//  UserList
//
//  Created by Valerii Mykhailenko on 8/16/18.
//  Copyright © 2018 Valerii Mykhailenko. All rights reserved.
//

import Foundation

extension String {
    
    var formattedNumber: String {
        
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "XXX-XXX-XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    

}
