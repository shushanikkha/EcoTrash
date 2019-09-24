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

class Trash: Codable {
    var location: CLLocationCoordinate2D
    var creationDate: Date
    var availableDate: Date?
    var user: User
    var type: String // Type
    var image: UIImage?
    var amount: Int?
    
    init(location: CLLocationCoordinate2D, creationDate: Date, availableDate: Date,  user: User, type: String, image: UIImage, amount: Int) {
        self.location = location
        self.creationDate = creationDate
        self.availableDate = availableDate
        self.user = user
        self.type = type
        self.image = image
        self.amount = amount
    }
    
    enum CodingKeys: String, CodingKey {
        case location
        case creationDate
        case availableDate
        case user
        case type
        case image
        case amount
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        amount = try container.decode(Int.self, forKey: .amount)
        
        let newCreationDate = try container.decode(Data.self, forKey: .creationDate)
        creationDate = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(newCreationDate) as? Date)!
        
        let newAvailableDate = try container.decode(Data.self, forKey: .creationDate)
        creationDate = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(newAvailableDate) as? Date)!
        
        let newImage = try container.decode(Data.self, forKey: .image)
        image = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(newImage) as? UIImage
        
        let newLocation = try container.decode(Data.self, forKey: .location)
        location = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(newLocation) as? CLLocationCoordinate2D)!
        
        let newUser = try container.decode(Data.self, forKey: .user)
        user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(newUser) as! User
 
    
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(type, forKey: .type)
           try container.encode(amount, forKey: .amount)
        let newLocation = try NSKeyedArchiver.archivedData(withRootObject: location, requiringSecureCoding: false)
            try container.encode(newLocation, forKey: .location)
        let newCreationDate = try NSKeyedArchiver.archivedData(withRootObject: creationDate, requiringSecureCoding: false)
            try container.encode(newCreationDate, forKey: .creationDate)
        let newAvailableDate = try NSKeyedArchiver.archivedData(withRootObject: availableDate, requiringSecureCoding: false)
            try container.encode(newAvailableDate, forKey: .availableDate)
        let newUser = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
            try container.encode(newUser, forKey: .user)
        let newImage = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: false)
            try container.encode(newImage, forKey: .image)
    }
    
    
}
