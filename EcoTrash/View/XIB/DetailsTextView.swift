//
//  DetailsTextView.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/7/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class DetailsTextView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var detailsTextView: UITextView!
    
    override func awakeFromNib() {
        detailsTextView.layer.cornerRadius = 6.0
        detailsTextView.layer.borderWidth = 0.5
        detailsTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
    }

}
