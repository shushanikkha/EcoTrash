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
    
//    private func changTextField(_ textField: UITextField, _ bColor: UIColor, _ bWidth: CGFloat) {
//        textField.layer.borderWidth = bWidth
//        textField.layer.borderColor = bColor.cgColor
//    }
//    
//    private func validField(textField: UITextField, userType: UserType) -> String? {
//        switch userType {
//        case .firstName:
//            return viewModel.isValidFirstName(textField.text)
//        case .lastName:
//            return viewModel.isValidLastName(textField.text)
//        case .email:
//            return viewModel.isValidEmail(textField.text)
//        case .phoneNumber:
//            return viewModel.isValidPhone(textField.text)
//        case .password:
//            return viewModel.isValidPsaaword(textField.text)
//        case .confirmPassword:
//            return viewModel.isValidConfirmP(textField.text)
//        }
//    }
//    
//    func setup(textField: UITextField, label: UILabel, userType: UserType) {
//        if let error = validField(textField: textField, userType: userType) {
//            label.text = error
//            label.isHidden = false
//            changTextField(textField, .red, 1)
//        } else {
//            label.isHidden = true
//            changTextField(textField, .black, 0.5)
//        }
//    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        
    }
    
    @IBAction func textFieldDidEnd(_ sender: UITextField) {
//        setup(textField: sender, label: errorLabel, userType: UserType)
    }
    
    
    
    
    
    func showErrorLabel() {
        if registrationTextField.text!.isEmpty {
          errorLabel.isHidden = false
        }
    }
}
