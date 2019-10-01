//
//  FieldView.swift
//  EcoTrash
//
//  Created by Admin on 9/20/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit

protocol FieldViewDelegate {
    func showFieldView()
}

class FieldView: UIView, UITextFieldDelegate {
    
    @IBOutlet private weak var field: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    
    var validationClosure: ((String?) -> String?)?
    
    var inValidate: ((Bool) -> Void)?
    
    var isValid: Bool {
        guard let closure = self.validationClosure else { return false }
        return closure(field.text) == nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
