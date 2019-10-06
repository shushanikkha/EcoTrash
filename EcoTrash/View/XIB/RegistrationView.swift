//
//  RegistrationView.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/2/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class RegistrationView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var registrationTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
//    override func awakeFromNib() {
//        errorLabel.isHidden = true
//        contentView.layer.cornerRadius = 4.0
//        contentView.layer.borderWidth = 0.5
//        contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
//
//    }

    func showErrorLabel() {
        if registrationTextField.text!.isEmpty {
          errorLabel.isHidden = false
        }
    }
}
