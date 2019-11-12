//
//  RecycleWaste.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/13/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit


class RecycleWaste {
    var imageUrl: URL?
    var recycle: String
    var name: String
    
    init(imageUrl: URL?, recycleResult: String, name: String) {
        self.imageUrl = imageUrl
        self.recycle = recycleResult
        self.name = name
    }
    
}
