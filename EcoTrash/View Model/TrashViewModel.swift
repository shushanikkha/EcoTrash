//
//  TrashViewModel.swift
//  EcoTrash
//
//  Created by Admin on 9/29/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class TrashViewModel {
    
    var trash: Trash!
    
    var latitude: Double?
    var longitude: Double?
    
    var creationDate: String?
    var availableDate: String?
    var user = User(firstName: "Aaaaaa", lastName: "Aaaaaaa", email: "as@aa.aa", phoneNumber: "+77777777777", password: "aaaaaaaa", confirmPassword: "aaaaaaaaa", id: "aaaaaaaa")
    var type: String?
    var images: [UIImage]?
    var amount: Int?
    var address: String?
    
    var refTrash = DatabaseReference()
    
    
    func convertImageToBase64String(image: UIImage?) -> String {
        guard let image = image else { return "" }
        
        return image.jpegData(compressionQuality: 0)?.base64EncodedString() ?? ""
    }
    
    private func toAny() -> [String: Any] {
        
        var imagesStrData: [String] = [""]
        
        if images != nil {
            for image in images! {
                let imageStrData = convertImageToBase64String(image: image)
                imagesStrData.append(imageStrData)
            }
        }
        
        return [
            "latitude": latitude!,
            "longitude": longitude!,
            "creationDate": creationDate!,
            "availableDate": availableDate!,
            "user": user.toAny(),
            "type": type!,
            "images": imagesStrData,
            "amount": amount!,
            "address": address!
        ]
    }
    
    private func chackTrash() -> Bool {
        guard let latitude = latitude, let longitude = longitude, let creationDate = creationDate, let type = type, let amount = amount, let address = address else { return false }
        
        trash = Trash(latitude: latitude, longitude: longitude, creationDate: creationDate, availableDate: availableDate, user: user, type: type, images: images, amount: amount, address: address)
        
        print("chackTrash")
        return true
    }
    
    func addTrash() -> Bool {
        guard chackTrash() else { return false }
        
        let key = refTrash.childByAutoId().key
        guard let id = key else { return false }
        print(toAny())
        
        refTrash.child(id).setValue(toAny())
        
        return true
    }
    
}
