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
    
    var validationClosure: ((String?) -> String?)?

    var inValidate: ((Bool) -> Void)?

    var isValid: Bool {
        guard let closure = self.validationClosure else { return false }
        return closure(registrationTextField.text) == nil
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func showErrorLabel() {
        if registrationTextField.text!.isEmpty {
          errorLabel.isHidden = false
        }
    }
}
