//
//  NewsfeedDetailsImageCell.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/4/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class NewsfeedDetailsImageCell: UICollectionViewCell {
    @IBOutlet weak var newsfeedDetailsImageView: UIImageView!
    
    func setup(with image: UIImage) {
        newsfeedDetailsImageView.image = image
    }
    
}
