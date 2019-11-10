//
//  Marker.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/4/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Trash {
    
    var latitude: Double
    var longitude: Double
    
    var creationDate: String
    var availableDate: String?
    var user: User
    var type: String
    var images: [UIImage]?
    var amount: Int
    var address: String
    var id: String

    init(latitude: Double, longitude: Double, creationDate: String, availableDate: String?, user: User, type: String, images: [UIImage]?, amount: Int, address: String, id: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.creationDate = creationDate
        self.availableDate = availableDate
        self.user = user
        self.type = type
        self.images = images
        self.amount = amount
        self.address = address
        self.id = id
    }
}
