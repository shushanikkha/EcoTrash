//
//  CompanyShortList.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/7/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit

class CompanyShortList {
    var name: String
    var image: UIImage
    var address: String
    
    init(name: String, image: UIImage, address: String) {
        self.name = name
        self.image = image
        self.address = address
    }
}
