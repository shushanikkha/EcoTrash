//
//  RegisterViewController.swift
//  EcoTrash
//
//  Created by Admin on 9/1/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }

    func chackTexField () -> Bool {
        guard nameTextField.text != "" else {
            showAlert(title: "Name" , message: "is empty", textField: nameTextField)
            return false
        }
        guard !nameTextField.text!.containsEmoji else {
            showAlert(title: "Name" , message: "conteins emoji", textField: nameTextField)
            return false
        }
        nameTextField?.layer.borderWidth = 0
        nameTextField?.layer.borderColor = UIColor.red.cgColor
        guard surnameTextField.text != "" else {
            showAlert(title: "Surname" , message: "is empty", textField: surnameTextField)
            return false
        }
        surnameTextField?.layer.borderWidth = 0
        surnameTextField?.layer.borderColor = UIColor.red.cgColor
        guard emailTextField.text != "" else {
            showAlert(title: "Email" , message: "is empty", textField: emailTextField)
            return false
        }
        guard emailTextField.text!.contains("@") else {
            showAlert(title: "Eail" , message: "wrong mail", textField: emailTextField)
            return false
        }
        emailTextField?.layer.borderWidth = 0
        emailTextField?.layer.borderColor = UIColor.red.cgColor
        guard phoneNumberTextField.text != "" else {
            showAlert(title: "Phone Number " , message: "is empty", textField: phoneNumberTextField)
            return false
        }
        phoneNumberTextField?.layer.borderWidth = 0
        phoneNumberTextField?.layer.borderColor = UIColor.red.cgColor
        guard passwordTextField.text != "" else {
            showAlert(title: "Password" , message: "is empty", textField: passwordTextField)
            return false
        }
        passwordTextField?.layer.borderWidth = 0
        passwordTextField?.layer.borderColor = UIColor.red.cgColor
        guard confirmPTextField.text == passwordTextField.text else {
            showAlert(title: "Confirm Password" , message: "wrong confirm password", textField: confirmPTextField)
            return false
        }
        confirmPTextField?.layer.borderWidth = 0
        confirmPTextField?.layer.borderColor = UIColor.red.cgColor
       
        return true
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
    
    
    @IBAction func subbmitTapped(_ sender: UIButton) {
        guard chackTexField() else { return }
            //TODO: Armen subbmit
            print("succes")
    }
    
    
    
    
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


extension UnicodeScalar {
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        0x1F018...0x1F270, // Various asian characters
        0x238C...0x2454, // Misc items
        0x20D0...0x20FF: // Combining Diacritical Marks for Symbols
            return true
            
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}


extension String {
    var glyphCount: Int {
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }
    
    var isSingleEmoji: Bool {
        return glyphCount == 1 && containsEmoji
    }
    
    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }
    
    var containsOnlyEmoji: Bool {
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji && !$0.isZeroWidthJoiner
            })
    }
}
