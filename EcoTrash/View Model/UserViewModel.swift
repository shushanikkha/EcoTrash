//
//  UserViewModel.swift
//  EcoTrash
//
//  Created by Admin on 9/10/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FieldView: UIView, UITextFieldDelegate {
    
    @IBOutlet private weak var field: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    
    var validationClosure: ((String?) -> String?)?
    
    var inValidate: ((Bool) -> Void)?
    
    var isValid: Bool {
        guard let closure = self.validationClosure else { return false }
        return closure(field.text) == nil
    }
}

class UserViewModel {
    
    weak var vc: RegisterViewController?
    var fieldViews = [FieldView]()
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var password: String!
    var confirmPassword: String!
    
    var user: User!
    
    var refUser = DatabaseReference()
    
    private func validateTextField(text: String, predicatStyl: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", predicatStyl).evaluate(with: text)
    }
    
    func isValidFirstName(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "First name is empty"
        }
        guard text.count >= 3  else {
            return "First name count less then 3"
        }
        let predicatStyl = "[A-Z]+[A-Z0-9a-z]{3,10}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "First name is not valid Ex.(Adam)"
        }
        return nil
    }
    
    func isValidLastName(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Last name is empty"
        }
        guard text.count >= 3  else {
            return "Last name count less then 3"
        }
        let predicatStyl = "[A-Z]+[A-Z0-9a-z]{3,10}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Last name is not valid Ex.(Adamyan)"
        }
        return nil
    }
    
    func isValidEmail(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Email is empty"
        }
        let predicatStyl = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        guard text.count >= 3 && validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Email is not valid Ex.(contact@onex.am)"
        }
        return nil
    }
    
    func isValidPhone(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Phone is empty"
        }
        let predicatStyl = "[+]+[0-9]{5,}"
        guard text.count >= 7 || validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Phone is not valid Ex.(077777777)"
        }
        return nil
    }
    
    func isValidPsaaword(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Password is empty"
        }
        guard text.count >= 6  else {
            return "Password count less then 6"
        }
        let predicatStyl = "[A-Z0-9a-z!-+]{6,}"
        guard validateTextField(text: text, predicatStyl: predicatStyl) else {
            return "Password is not valid Ex.(_______)"
        }
        return nil
    }
    
    func isValidConfirmP(_ text: String?) -> String? {
        guard let text = text, text != "" else {
            return "Confirm password is empty"
        }
        guard let password = password, text == password else {
            return "Wrong confirm password"
        }
        return nil
    }
    
    func notError() -> Bool {
        if let _ = isValidFirstName(firstName) {
            return false
        } else if let _ = isValidLastName(lastName) {
            return false
        } else if let _ = isValidEmail(email) {
            return false
        } else if let _ = isValidPhone(phoneNumber) {
            return false
        } else if let _ = isValidPsaaword(password) {
            return false
        } else if let _ = isValidConfirmP(confirmPassword) {
            return false
        } else {
            return true
        }
    }
    
    func addUser() {
        guard notError() else { return }
        
        let key = refUser.childByAutoId().key
        
        guard let id = key else { return }

        user = User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, password: password, confirmPassword: confirmPassword, id: id)
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration succesful")
            }
        }
        
        refUser.child(id).setValue(user.toAny())
    }
    

}
