//
//  UserSettingsViewController.swift
//  EcoTrash
//
//  Created by Admin on 10/20/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        UserDefaults.standard.set(false, forKey: "isLogged")
        UserDefaults.standard.set(nil, forKey: "mail")
        self.present(loginVC, animated: false, completion: nil)
    }
    
}
