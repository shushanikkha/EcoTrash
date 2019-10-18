//
//  Event.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/3/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit


class Event {
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    var imageUrl: URL?
    var name: String
    var address: String
    var description: String
    var phone: String
    var date: String
    var time: String
    var registrationLink: String

    var formattedDate: Date? {
        return dateFormatter.date(from: date)
    }
    
    init(imageUrl: URL?, name: String, description: String, phone: String , address: String, date: String, time: String, registrationLink: String) {
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
        self.address = address
        self.description = description
        self.phone = phone
        self.date = date
        self.time = time
        self.registrationLink = registrationLink
    }
}
