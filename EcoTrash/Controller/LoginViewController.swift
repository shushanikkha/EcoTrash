//
//  LoginViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/1/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
   
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
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
                print("Login succesful")
                sender.backgroundColor = .white
                guard let tabBarC = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarController") else { return }
                self.present(tabBarC, animated: true, completion: nil)
            }
        }
    }
    
}

