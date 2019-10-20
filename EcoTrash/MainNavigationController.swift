//
//  MainNavigationController.swift
//  EcoTrash
//
//  Created by Admin on 10/15/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        DispatchQueue.main.async {
            if self.isLoggedIn() {
                self.showHomeVC()
            } else {
                self.showLoginVC()
            }
        }
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLogged")
    }

    func showLoginVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        self.present(loginVC, animated: false, completion: nil)
    }
    
    func showHomeVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController else { return }
        present(tabBarC, animated: false, completion: nil)
    }

    
//    func loadUsers() {
//        self.ref.child("users").observe(.value) { (snapshot) in
//            DispatchQueue.main.async {
//                guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
//                
//                for snap in snapshot {
//                    guard let userDict = snap.value as? StringAny else { return }
//                    
//                    let user = self.parsUser(userDict)
//                    self.users.append(user)
//                }
//            }
//        }
//    }
//    
//    func getUser() -> User {
//        guard let mail = UserDefaults.standard.object(forKey: "mail") as? String else { return User() }
//        
//        for user in users {
//            if user.email == mail {
//                return user
//            }
//        }
//        return User()
//    }
}
