//
//  RegisterViewController.swift
//  EcoTrash
//
//  Created by Admin on 9/1/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SwiftKeychainWrapper

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPTextField: UITextField!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPLabel: UILabel!
    
    @IBOutlet weak var subbmitButton: UIButton!
    
    var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel.refUser = Database.database().reference()
        viewModel.refUser = Database.database().reference().child("users")
        
        subbmitButton.backgroundColor = .white
        subbmitButton.isEnabled = false
        registerForKeyboardNotifications()
    }

//    func showAlert(title: String?, message: String?, textField: UITextField?) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//        alert.addAction(alertAction)
//
//        self.present(alert, animated: true, completion: {
//            textField?.layer.borderWidth = 1
//            textField?.layer.borderColor = UIColor.red.cgColor
//        })
//    }
    
    private func changTextField(_ textField: UITextField, _ bColor: UIColor, _ bWidth: CGFloat) {
        textField.layer.borderWidth = bWidth
        textField.layer.borderColor = bColor.cgColor
    }
    
    private func validField(textField: UITextField, userType: UserType) -> String? {
        switch userType {
        case .firstName1:
            return viewModel.isValidFirstName(textField.text)
        case .lastName1:
            return viewModel.isValidLastName(textField.text)
        case .email1:
            return viewModel.isValidEmail(textField.text)
        case .phoneNumber1:
            return viewModel.isValidPhone(textField.text)
        case .password1:
            return viewModel.isValidPsaaword(textField.text)
        case .confirmPassword1:
            return viewModel.isValidConfirmP(textField.text)
        }
    }
    
    private func setup(textField: UITextField, label: UILabel, userType: UserType) {
        if let error = validField(textField: textField, userType: userType) {
            label.text = error
            label.isHidden = false
            changTextField(textField, .red, 1)
        } else {
            label.isHidden = true
            changTextField(textField, .black, 0.5)
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func firstNameEditingCanging(_ sender: Any) {
        viewModel.firstName = firstNameTextField.text
        subbmitButton.isEnabled = viewModel.notError()
    }
    
    @IBAction func lastNameNameEditingCanging(_ sender: Any) {
        viewModel.lastName = lastNameTextField.text
        subbmitButton.isEnabled = viewModel.notError()
    }
    
    @IBAction func emailEditingCanging(_ sender: Any) {
        viewModel.email = emailTextField.text
        subbmitButton.isEnabled = viewModel.notError()
    }
    
    @IBAction func phoneEditingCanging(_ sender: Any) {
        viewModel.phoneNumber = phoneNumberTextField.text
        subbmitButton.isEnabled = viewModel.notError()
    }
    
    @IBAction func passwordEditingCanging(_ sender: Any) {
        viewModel.password = passwordTextField.text
        subbmitButton.isEnabled = viewModel.notError()
    }
    
    @IBAction func confirmPEditingCanging(_ sender: Any) {
        viewModel.confirmPassword = confirmPTextField.text
        subbmitButton.isEnabled = viewModel.notError()
    }
    
    
    @IBAction func firstNameDidEnd(_ sender: UITextField) {
        setup(textField: sender, label: firstNameLabel, userType: .firstName1)
    }
    
    @IBAction func lastNameDidEnd(_ sender: UITextField) {
        setup(textField: sender, label: lastNameLabel, userType: .lastName1)
    }
    
    @IBAction func emailDidEnd(_ sender: UITextField) {
        setup(textField: sender, label: emailLabel, userType: .email1)
    }
    
    @IBAction func phoneDidEnd(_ sender: UITextField) {
        setup(textField: sender, label: phoneLabel, userType: .phoneNumber1)
    }
    
    @IBAction func passwordDidEnd(_ sender: UITextField) {
        setup(textField: sender, label: passwordLabel, userType: .password1)
    }
    
    @IBAction func confirmPDidEnd(_ sender: UITextField) {
        setup(textField: sender, label: confirmPLabel, userType: .confirmPassword1)
    }
    
    @IBAction func subbmitTapped(_ sender: UIButton) {
        viewModel.reg(from: self) { (error) in
            if error != nil {
                print(error.debugDescription)
                sender.backgroundColor = .red
            } 
        }
    }
}
