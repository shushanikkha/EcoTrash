//
//  LoginViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/1/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var ecoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var rememberImageView: UIImageView!
    @IBOutlet weak var rememberLayer: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        registerButton.layer.cornerRadius = registerButton.frame.height / 4
        loginButton.layer.cornerRadius = loginButton.frame.height / 4
        ecoImageView.layer.cornerRadius = ecoImageView.frame.height / 16
        rememberLayer.layer.borderWidth = 0.5
        registerForKeyboardNotifications()
    }
    
    // MARK: - IBActions -
    
    @IBAction func registrationButton(_ sender: UIButton) {
        guard let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        
        let navVC = UINavigationController(rootViewController: registerVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        UserDefaults.standard.set(!self.rememberImageView.isHidden, forKey: "isLogged")
        viewModel.login(with: emailTextField.text, and: passwordTextField.text, from: self) { (error) in
            guard let error = error else { return }
            print(error)
            sender.backgroundColor = .red
        }
    }
    
    @IBAction func rememberTapped(_ sender: UIButton) {
        rememberImageView.isHidden = !rememberImageView.isHidden
    }
    
    
    //MARK: Keyboard Notification
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.view.endEditing(true)
    }
    
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

