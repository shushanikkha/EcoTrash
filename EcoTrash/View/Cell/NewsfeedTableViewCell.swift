//
//  NewsfeedTableViewCell.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/30/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class NewsfeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trashAddress: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var trashAmount: UILabel!
    @IBOutlet weak var trashImage: UIImageView?
    

    
    // MARK: - Method -
    
    func update (with trash: Trash) {
        trashAddress.text = trash.address
        creationDate.text = creationDate.text
        if let trashImage = self.trashImage {
            trashImage.image = trash.image
        }
    }

}
