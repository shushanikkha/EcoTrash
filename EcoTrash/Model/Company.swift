//
//  Company.swift
//  EcoTrash
//
//  Created by Admin on 9/30/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit

class Company {
    var name: String
    var image: UIImage?
    var address: String
    var description: String
    var phone: String
    var email: String
    var garbageType: String
    
    init(name: String, image: UIImage?, address: String, description: String, phone: String, email: String, garbageType: String) {
        self.name = name
        self.image = image
        self.address = address
        self.description = description
        self.phone = phone
        self.email = email
        self.garbageType = garbageType
    }
    
}

enum Type: String {
    case plastic , paper , glass , other
}
