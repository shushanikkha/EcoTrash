//
//  TrashImageCollectionViewCell.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/1/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit



class TrashImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    func setUp(with image: UIImage) {
        imageView.image = image
    }
}
