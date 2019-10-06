//
//  NewsfeedTableViewCell.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/30/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class NewsfeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var trashImageView: UIImageView!
    

    // MARK: - Method -
    func setup(with trash: Trash) {
        addressLabel.text = trash.address
        dateLabel.text = trash.creationDate
        amountLabel.text = "\(String(trash.amount)) կգ"
        
        if let image = trash.images?.first {
            trashImageView.image = image
        }
    }
    
}
