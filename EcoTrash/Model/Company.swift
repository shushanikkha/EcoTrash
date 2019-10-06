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
    var imageUrl: URL?
    var name: String
    var address: String
    var description: String
    var phone: String
    var email: String
    var garbageType: String
    

    init(imageUrl: URL?, name: String, description: String, email: String , phone: String , address: String , garbageType: String) {
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
        self.address = address
        self.description = description
        self.phone = phone
        self.email = email
        self.garbageType = garbageType
    }
    
    
    
}

