//
//  UserViewModel.swift
//  EcoTrash
//
//  Created by Admin on 9/10/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//
import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth
import SwiftKeychainWrapper


enum UserType {
    case firstName1, lastName1, email1, phoneNumber1, password1, confirmPassword1
}

class UserViewModel {
    
    weak var vc: RegisterViewController?
   // var fieldViews = [FieldView]()
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var password: String!
    var confirmPassword: String!
    
    var user: User!
    
    var users = [User]()
    
    var refUser = DatabaseReference()
    
    private func validateTextField(text: String, predicatStyl: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", predicatStyl).evaluate(with: text)
    }
    
    func isValidFirstName(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Լրացրեք Ձեր անունը"
        }
        guard text.count >= 3  else {
            return "Անունը 3 տառից պակաս չի կարող լինել"
        }
        let predicatStyl = "[A-Z]+[A-Z0-9a-z]{3,10}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Անունը վավեր չէ, օր.(Արամ)"
        }
        return nil
    }
    
    func isValidLastName(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Լրացրեք Ձեր ազգանունը"
        }
        guard text.count >= 3  else {
            return "Ազգանունը 3 տառից պակաս չի կարող լինել"
        }
        let predicatStyl = "[A-Z]+[A-Z0-9a-z]{3,10}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Ազգանունը վավեր չէ, օր.(Ադամյան)"
        }
        return nil
    }
    
    func isValidEmail(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Լրացրեք էլ հասցեն"
        }
        let predicatStyl = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        guard text.count >= 3 && validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Էլ հասցեն վավեր չէ, օր.(contact@onex.am)"
        }
        email = text
        return nil
    }
    
    func isValidPhone(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Լրացրեք հեռախոսահամարը"
        }
        let predicatStyl = "[+]+[0-9]{11}"
        guard text.count >= 7 || validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Հեռախոսահամարը վավեր չէ, օր.(077777777)"
        }
        return nil
    }
    
    func isValidPsaaword(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Լրացրեք գաղտնաբառը"
        }
        guard text.count >= 6  else {
            return "Գաղտնաբառը 6 տառից պակաս չի կարող լինել"
        }
        let predicatStyl = "[A-Z0-9a-z!-+]{6,}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Գաղտնաբառը վավեր չէ, օր.(_______)"
        }
        return nil
    }
    
    func isValidConfirmP(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Կրկնել գաղտնաբառը"
        }
        guard let password = password, text == password else {
            return "Գաղտնաբառը սխալ է գրված"
        }
        return nil
    }
    
    func notError() -> Bool {
        guard isValidFirstName(firstName) == nil , isValidLastName(lastName) == nil , isValidEmail(email) == nil , isValidPhone(phoneNumber) == nil , isValidPsaaword(password) == nil , isValidConfirmP(confirmPassword) == nil else { return false }
            return true
    }
    
    func addUser() -> Bool {
        guard notError() else { return  false }
        
        let key = refUser.childByAutoId().key
        guard let id = key else { return false }
        
        user = User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, password: password, confirmPassword: confirmPassword, id: id)
        refUser.child(id).setValue(user.toAny())
        return true
    }
    
    func login(with email: String?, and password: String?, from vc: UIViewController, completion: @escaping (Error?) -> Void) {
        guard let email = email, let password = password else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                self.loginLogic(with: email, from: vc)
            }
            completion(error)
        }
    }
    
    func reg(from vc: UIViewController, completion: @escaping (Error?) -> Void) {
        guard addUser() else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                self.loginLogic(with: self.email, from: vc)
            }
            completion(error)
        }
    }
    
    private func loginLogic(with email: String, from vc: UIViewController) {
        UserDefaults.standard.set(email, forKey: "mail")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loadUsersWithMail(mail: email)
        let tabBarC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController")
        vc.present(tabBarC, animated: true, completion: nil)
    }
    
    func loadUsersWithMail(mail: String) {
//        guard let mail = UserDefaults.standard.object(forKey: "mail") as? String else { return }
        refUser = Database.database().reference().child("users")
        
        refUser.observe(.value) { (snapshot) in
            DispatchQueue.main.async {
                guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
                
                for snap in snapshot {
                    guard let userDict = snap.value as? [String: Any] else { return }
                    
                    let firstName = userDict["firstName"] as! String
                    let lastName = userDict["lastName"] as! String
                    let email = userDict["email"] as! String
                    let phoneNumber = userDict["phoneNumber"] as! String
                    let id = userDict["id"] as! String
                    
                    let user = User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: id)
                    self.users.append(user)
                    
                    if user.email == mail {
                        UserDefaults.standard.set(user.toAny(), forKey: "userDict")
                        self.user = user
                    }
                }
            }
        }
    }
}
