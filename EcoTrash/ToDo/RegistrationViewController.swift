//
//  RegistrationViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/2/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    
     private  var firstNameVIew: RegistrationView?
     private  var lastNameVIew: RegistrationView?
     private  var emailView: RegistrationView?
     private  var phoneNumberView: RegistrationView?
     private  var passwordView: RegistrationView?
     private  var confirmPasswordView: RegistrationView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegistrationView()
    }
       
    private func setupRegistrationView() {
        let width = UIScreen.main.bounds.size.width - 20
        if let firstNameVIew = Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)?.first as? RegistrationView {
            mainStackView.addSubview(firstNameVIew)
            let frame = CGRect(x: 0, y: 20, width: width, height: 70)
            firstNameVIew.frame = frame
            self.firstNameVIew = firstNameVIew
        }
        firstNameVIew?.registrationTextField.placeholder = "First Name"
        firstNameVIew?.errorLabel.text = "Enter your first name"
        
        if let lastNameVIew = Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)?.first as? RegistrationView {
            mainStackView.addSubview(lastNameVIew)
            let frame = CGRect(x: 0, y: 110, width: width, height: 70)
            lastNameVIew.frame = frame
            self.lastNameVIew = lastNameVIew
        }
        lastNameVIew?.registrationTextField.placeholder = "Last Name"
        lastNameVIew?.errorLabel.text = "Enter your last name"
        
        if let emailView = Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)?.first as? RegistrationView {
            mainStackView.addSubview(emailView)
            let frame = CGRect(x: 0, y: 200, width: width, height: 70)
            emailView.frame = frame
            self.emailView = emailView
        }
        emailView?.registrationTextField.placeholder = "Email"
        emailView?.errorLabel.text = "Enter your email"
        
        if let phoneNumberView = Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)?.first as? RegistrationView {
            mainStackView.addSubview(phoneNumberView)
            let frame = CGRect(x: 0, y: 290, width: width, height: 70)
            phoneNumberView.frame = frame
            self.phoneNumberView = phoneNumberView
        }
        phoneNumberView?.registrationTextField.placeholder = "Phone number"
        phoneNumberView?.errorLabel.text = "Enter your phone number"
        
        if let passwordView = Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)?.first as? RegistrationView {
            mainStackView.addSubview(passwordView)
            let frame = CGRect(x: 0, y: 380, width: width, height: 70)
            passwordView.frame = frame
            self.passwordView = passwordView
        }
        passwordView?.registrationTextField.placeholder = "Password"
        passwordView?.errorLabel.text = "Enter your password"
        
        if let confirmPasswordView = Bundle.main.loadNibNamed("RegistrationView", owner: self, options: nil)?.first as? RegistrationView {
            mainStackView.addSubview(confirmPasswordView)
            let frame = CGRect(x: 0, y: 470, width: width, height: 70)
            confirmPasswordView.frame = frame
            self.confirmPasswordView = confirmPasswordView
        }
        confirmPasswordView?.registrationTextField.placeholder = "Confirm Password"
        confirmPasswordView?.errorLabel.text = "Confirm your password"
    }
    
    
    // MARK: - IBActions -

    @IBAction func registrateButton(_ sender: UIButton) {
        if firstNameVIew?.registrationTextField.text!.isEmpty == true {
            firstNameVIew?.showErrorLabel()
        } else if lastNameVIew?.registrationTextField.text!.isEmpty == true {
            lastNameVIew?.showErrorLabel()
        } else if emailView?.registrationTextField.text!.isEmpty == true {
            emailView?.showErrorLabel()
        } else if phoneNumberView?.registrationTextField.text!.isEmpty == true {
            phoneNumberView?.showErrorLabel()
        } else if passwordView?.registrationTextField.text!.isEmpty == true {
            passwordView?.showErrorLabel()
        }else if confirmPasswordView?.registrationTextField.text!.isEmpty == true {
            confirmPasswordView?.showErrorLabel()
        }
    }
    

}
