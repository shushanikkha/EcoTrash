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
   
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var rememberImageView: UIImageView!
    @IBOutlet weak var rememberLayer: UIView!
    
    var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberLayer.layer.borderWidth = 0.5
    }
    
    // MARK: - IBActions -
    
    @IBAction func registrationButton(_ sender: UIButton) {
        guard let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        
        let navVC = UINavigationController(rootViewController: registerVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        viewModel.login(with: emailTextField.text, and: passwordTextField.text, from: self) { (error) in
            guard let error = error else { return }
            print(error)
            sender.backgroundColor = .red
            UserDefaults.standard.set(!self.rememberImageView.isHidden, forKey: "isLogged")
        }
    }
    
    @IBAction func rememberTapped(_ sender: UIButton) {
        rememberImageView.isHidden = !rememberImageView.isHidden
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.view.endEditing(true)
    }
    
}

