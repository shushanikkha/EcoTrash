//
//  Company.swift
//  EcoTrash
//
//  Created by Gev Darbinyan on 06/09/2019.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit

enum Type {
    case plastic , paper , glass , other
}

class Company {
    var name: String
    var email: String
    var phone: String
    var address: String
    var garbageType: Type
    
    init(name: String , email: String , phone: String , address: String , garbageType: Type) {
        self.name = name
        self.address = address
        self.phone = phone
        self.email = email
        self.garbageType = garbageType
    }
}
