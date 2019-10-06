//
//  DetailsLabelView.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/4/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit

class DetailsLabelView: UIView {
    
    @IBOutlet weak var detailsContentView: UIView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailsNameLabel: UILabel!
    
    override func awakeFromNib() {
        detailsNameLabel.layer.cornerRadius = 4.0
        detailsNameLabel.layer.borderWidth = 0.5
        detailsNameLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
    }
    
}


