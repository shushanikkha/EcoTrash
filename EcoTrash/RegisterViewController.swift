//
//  RegisterViewController.swift
//  EcoTrash
//
//  Created by Admin on 9/1/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

protocol RegisterViewControllerDelegate {
    func userCreted(user: User)
}

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
    

    var user: User {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let phoneNumber = phoneNumberTextField.text!
        let password = passwordTextField.text!
        let comfirmPasswodr = confirmPTextField.text!
        
        return User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, password: password, comfirmPasswodr: comfirmPasswodr)
    }
    
    var checks = Array(repeating: false, count: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    

    func showAlert(title: String?, message: String?, textField: UITextField?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: {
            textField?.layer.borderWidth = 1
            textField?.layer.borderColor = UIColor.red.cgColor
        })
    }
    
    
    private func validateTextField(text: String, predicatStyl: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", predicatStyl).evaluate(with: text)
    }
    
    private func configTextField(_ textField: UITextField, _ bColor: UIColor, _ bWidth: CGFloat) {
        textField.layer.borderWidth = bWidth
        textField.layer.borderColor = bColor.cgColor
    }
    
    
    @IBAction func firstNameDidEnd(_ sender: UITextField) {
        guard let text = sender.text, text != "" else {
            firstNameLabel.text = "First Name is empty"
            firstNameLabel.isHidden = false
            checks[0] = false
            configTextField(sender, .red, 1)
            return
        }
        
        guard text.count >= 3  else {
            firstNameLabel.text = "First Name count less then 3"
            checks[0] = false
            configTextField(sender, .red, 1)
            return
        }

        let predicatStyl = "[A-Z]+[A-Z0-9a-z]{3,10}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            firstNameLabel.text = "is not valid Ex.(Adam)"
            checks[0] = false
            return
        }
        
        checks[0] = true
        firstNameLabel.isHidden = true
        configTextField(sender, .black, 0.5)
    }
    
    @IBAction func lastNameDidEnd(_ sender: UITextField) {
        guard let text = sender.text, text != "" else {
            lastNameLabel.text = "Last Name is empty"
            checks[1] = false
            lastNameLabel.isHidden = false
            configTextField(sender, .red, 1)
            return
        }
        
        guard text.count >= 3  else {
            lastNameLabel.text = "Last Name count less then 3"
            checks[1] = false
            configTextField(sender, .red, 1)
            return
        }
        
        let predicatStyl = "[A-Z]+[A-Z0-9a-z]{3,10}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            lastNameLabel.text = "is not valid Ex.(Poxosyan)"
            checks[1] = false
            return
        }
        
        checks[1] = true
        lastNameLabel.isHidden = true
        configTextField(sender, .black, 0.5)
    }
    
   
    @IBAction func emailDidEnd(_ sender: UITextField) {
        guard let text = sender.text, text != "" else {
            emailLabel.text = "Email is empty"
            checks[2] = false
            emailLabel.isHidden = false
            configTextField(sender, .red, 1)
            return
        }
        
        guard text.count >= 3  else {
            emailLabel.text = "Email count less then 3"
            checks[2] = false
            configTextField(sender, .red, 1)
            return
        }
        
        let predicatStyl = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            emailLabel.text = "is not valid Ex.(contact@onex.am)"
            checks[2] = false
            return
        }
        
        checks[2] = true
        emailLabel.isHidden = true
        configTextField(sender, .black, 0.5)
    }
    
    
    @IBAction func phoneDidEnd(_ sender: UITextField) {
        guard let text = sender.text, text != "" else {
            phoneLabel.text = "Email is empty"
            checks[3] = false
            phoneLabel.isHidden = false
            configTextField(sender, .red, 1)
            return
        }
        
        guard text.count >= 5  else {
            phoneLabel.text = "Phone Number count less then 5"
            checks[3] = false
            configTextField(sender, .red, 1)
            return
        }
        
        let predicatStyl = "[0-9+]{5,}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            phoneLabel.text = "is not valid Ex.(077777777)"
            checks[3] = false
            return
        }
        
        checks[3] = true
        phoneLabel.isHidden = true
        configTextField(sender, .black, 0.5)
    }
    
    
    @IBAction func passwordDidEnd(_ sender: UITextField) {
        guard let text = sender.text, text != "" else {
            passwordLabel.text = "Password is empty"
            checks[4] = false
            passwordLabel.isHidden = false
            configTextField(sender, .black, 1)
            return
        }
        
        guard text.count >= 6  else {
            passwordLabel.text = "Phone Number count less then 6"
            checks[4] = false
            configTextField(sender, .red, 1)
            return
        }
        
        let predicatStyl = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            passwordLabel.text = "is not valid Ex.()"
            checks[4] = false
            return
        }
        
        checks[4] = true
        passwordLabel.isHidden = true
        configTextField(sender, .black, 0.5)
    }
    
    @IBAction func confirmPDidEnd(_ sender: UITextField) {
        guard passwordTextField.text == confirmPTextField.text && passwordTextField.text != "" else {
            confirmPLabel.text = "Wrong Config Password"
            checks[5] = false
            confirmPLabel.isHidden = false
            configTextField(sender, .red, 1)
            return
        }
        
        checks[5] = true
        confirmPLabel.isHidden = true
        configTextField(sender, .black, 0.5)
    }
    
    
    @IBAction func subbmitTapped(_ sender: UIButton) {
        firstNameDidEnd(firstNameTextField)
        lastNameDidEnd(lastNameTextField)
        emailDidEnd(emailTextField)
        phoneDidEnd(phoneNumberTextField)
        passwordDidEnd(passwordTextField)
        confirmPDidEnd(confirmPTextField)
        
        var count = 0
        
        checks.forEach { (check) in
            guard check == true else { return }
            count += 1
        }
        guard count == 6 else { return }
        //TODO: Armen subbmit
        print(user)
    }
    
}

extension RegisterViewController {
    
    // MARK: - Kayboard notification
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height - 40.0, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
