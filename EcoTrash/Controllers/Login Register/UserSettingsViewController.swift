//
//  UserSettingsViewController.swift
//  EcoTrash
//
//  Created by Admin on 10/20/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
   
   
    let userDict = UserDefaults.standard.dictionary(forKey: "userDict")
    var user: User {
        guard let userDict = UserDefaults.standard.dictionary(forKey: "userDict") else { return User()}
        
        let firstName = userDict["firstName"] as! String
        let lastName = userDict["lastName"] as! String
        let email = userDict["email"] as! String
        let phoneNumber = userDict["phoneNumber"] as! String
        let id = userDict["id"] as! String
        
        return User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInfo()
    }
    
    
  private  func setUserInfo() {
        self.firstNameTextField.text = user.firstName
        self.lastNameTextField.text = user.lastName
        self.emailTextField.text = user.email
        self.phoneNumberTextField.text = user.phoneNumber
    }
    
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.firstNameTextField.isEnabled = true
        self.lastNameTextField.isEnabled = true
        self.emailTextField.isEnabled = true
        self.phoneNumberTextField.isEnabled = true
        self.oldPasswordTextField.isEnabled = true
        self.newPasswordTextField.isEnabled = true
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        UserDefaults.standard.set(false, forKey: "isLogged")
        UserDefaults.standard.set(nil, forKey: "mail")
        self.present(loginVC, animated: false, completion: nil)
    }
    
}
