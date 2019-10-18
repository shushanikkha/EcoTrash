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
   
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var rememberImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberButton.layer.borderWidth = 0.5
    }
    
    // MARK: - IBActions -
    
    @IBAction func registrationButton(_ sender: UIButton) {
        guard let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        
        let navVC = UINavigationController(rootViewController: registerVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let mail = loginTextField.text, let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: mail, password: password) { (user, error) in
            if error != nil {
                print("Error", error!)
                sender.backgroundColor = .red
            } else {
                sender.backgroundColor = .white
                guard let tabBarC = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarController") else { return }
                UserDefaults.standard.set(mail, forKey: "mail")
                self.present(tabBarC, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func rememberTapped(_ sender: UIButton) {
        rememberImageView.isHidden = !rememberImageView.isHidden
        UserDefaults.standard.set(!rememberImageView.isHidden, forKey: "isLogged")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.view.endEditing(true)
    }
    
}

