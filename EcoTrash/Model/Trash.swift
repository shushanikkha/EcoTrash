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
    var location: CLLocationCoordinate2D
    var creationDate: Date
    var availableDate: Date?
    var user: User
    var type: String // Type
    var image: UIImage?
    var amount: Int?
    var address: String?
    
    init(location: CLLocationCoordinate2D, creationDate: Date, availableDate: Date,  user: User, type: String, image: UIImage, amount: Int) {
        self.location = location
        self.creationDate = creationDate
        self.availableDate = availableDate
        self.user = user
        self.type = type
        self.image = image
        self.amount = amount
    }
    
   
    
}
