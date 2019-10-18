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
    
    var creationDate: String!
    var availableDate: String?
    var type: String?
    var images: [UIImage]?
    var amount: Int?
    var address: String!
    
    let userDict = UserDefaults.standard.dictionary(forKey: "userDict")

    var user: User {
        let firstName = userDict!["firstName"] as! String
        let lastName = userDict!["lastName"] as! String
        let email = userDict!["email"] as! String
        let phoneNumber = userDict!["phoneNumber"] as! String
        let id = userDict!["id"] as! String
        
        return User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: id)
    }

    
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
            "user": userDict as Any,
            "type": type!,
            "images": imagesStrData,
            "amount": amount!,
            "address": address!
        ]
    }
    
    private func chackTrash() -> Bool {
        guard let latitude = latitude, let longitude = longitude, let type = type,
            let amount = amount else { return false }
        
        trash = Trash(latitude: latitude, longitude: longitude, creationDate: creationDate, availableDate: availableDate, user: user, type: type, images: images, amount: amount, address: address)
        
        return true
    }
    
    func addTrash() -> Bool {
        guard chackTrash() else { return false }
        
        let key = refTrash.childByAutoId().key
        guard let id = key else { return false }
        refTrash.child(id).setValue(toAny())
        return true
    }
    
}
