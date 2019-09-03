//
//  User.swift
//  EcoTrash
//
//  Created by Admin on 9/3/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation



class User {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String?
    var password: String
    var comfirmPasswodr: String
    
    init(firstName: String, lastName: String, email: String, phoneNumber: String?, password: String, comfirmPasswodr: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
        self.comfirmPasswodr = comfirmPasswodr
    }
    
}

