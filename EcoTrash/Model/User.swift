//
//  User.swift
//  EcoTrash
//
//  Created by Admin on 9/3/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit


class User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var password: String
    var confirmPassword: String
    var id: String
    
    init(firstName: String, lastName: String, email: String, phoneNumber: String, password: String = "", confirmPassword: String = "", id: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
        self.confirmPassword = confirmPassword
        self.id = id
    }

    func toAny() -> [String: Any] {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phoneNumber": phoneNumber,
            "id": id
        ]
    }
    
}

