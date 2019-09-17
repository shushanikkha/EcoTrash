//
//  RegisterViewController.swift
//  EcoTrash
//
//  Created by Admin on 9/1/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseDatabase



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
        
        viewModel.refUser = Database.database().reference().child("users")
        
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
        if let error = viewModel.isValidFirstName(sender.text) {
            firstNameLabel.text = error
            firstNameLabel.isHidden = false
            changTextField(sender, .red, 1)
        } else {
            firstNameLabel.isHidden = true
            changTextField(sender, .black, 0.5)
        }
    }
    
    @IBAction func lastNameDidEnd(_ sender: UITextField) {
        if let error = viewModel.isValidLastName(sender.text) {
            lastNameLabel.text = error
            lastNameLabel.isHidden = false
            changTextField(sender, .red, 1)
        } else {
            lastNameLabel.isHidden = true
            changTextField(sender, .black, 0.5)
        }
    }
    
    @IBAction func emailDidEnd(_ sender: UITextField) {
        if let error = viewModel.isValidEmail(sender.text) {
            emailLabel.text = error
            emailLabel.isHidden = false
            changTextField(sender, .red, 1)
        } else {
            emailLabel.isHidden = true
            changTextField(sender, .black, 0.5)
        }
    }
    
    @IBAction func phoneDidEnd(_ sender: UITextField) {
        if let error = viewModel.isValidPhone(sender.text) {
            phoneLabel.text = error
            phoneLabel.isHidden = false
            changTextField(sender, .red, 1)
        } else {
            phoneLabel.isHidden = true
            changTextField(sender, .black, 0.5)
        }
    }
    
    @IBAction func passwordDidEnd(_ sender: UITextField) {
        if let error = viewModel.isValidPsaaword(sender.text) {
            passwordLabel.text = error
            passwordLabel.isHidden = false
            changTextField(sender, .red, 1)
        } else {
            passwordLabel.isHidden = true
            changTextField(sender, .black, 0.5)
        }
    }
    
    @IBAction func confirmPDidEnd(_ sender: UITextField) {
        if let error = viewModel.isValidConfirmP(sender.text) {
            confirmPLabel.text = error
            confirmPLabel.isHidden = false
            changTextField(sender, .red, 1)
        } else {
            confirmPLabel.isHidden = true
            changTextField(sender, .black, 0.5)
        }
    }
    
    @IBAction func subbmitTapped(_ sender: UIButton) {
        viewModel.addUser()
    }
    
}
