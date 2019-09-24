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

//extension CLLocationCoordinate2D: Codable {
//
//}

struct Trash: Codable {
//    var location: CLLocationCoordinate2D
    var creationDate: Date
    var availableDate: Date?
    var creator: User
    var type: String
    var images: [Image]
    var amount: Int?    
}

struct Image: Codable {
    var url: URL?
    var localURL: URL?
    
    var image: UIImage? {
        guard let imageURL = self.localURL, let imageData = try? Data(contentsOf: imageURL) else { return nil }
        return UIImage(data: imageData)
    }
}
