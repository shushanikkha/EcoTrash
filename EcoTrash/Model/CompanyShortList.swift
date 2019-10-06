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
    var imageUrl: URL?
    var address: String
    
    init(name: String, imageUrl: URL?, address: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.address = address
    }
    
}
