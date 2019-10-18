//
//  RecycleWaste.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/13/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation

class RecycleWaste {
    var imageUrl: URL?
    var recycleResult: String
    var recycleWasteName: String
    
    
    init(imageUrl: URL?, recycleResult: String, recycleWasteName: String) {
        self.imageUrl = imageUrl
        self.recycleResult = recycleResult
        self.recycleWasteName = recycleWasteName
    }
    
}
