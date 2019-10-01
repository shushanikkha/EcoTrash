//
//  Company.swift
//  EcoTrash
//
//  Created by Gev Darbinyan on 06/09/2019.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit

enum Type: String {
    case plastic , paper , glass , other
}

class Company {
    var image: UIImage
    var name: String
    var description: String
    var email: String
    var phone: String
    var address: String
    var garbageType: Type
    
    init(image: UIImage, name: String, description: String, email: String , phone: String , address: String , garbageType: Type) {
        self.image = image
        self.name = name
        self.description = description
        self.address = address
        self.phone = phone
        self.email = email
        self.garbageType = garbageType
    }
}
