//
//  TextField.swift
//  EcoTrash
//
//  Created by Admin on 9/3/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

protocol TextFieldDelegate {
    func textFieldName(name: String)
}

class TextField: UIView, TextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet var contentView: UIView!
    
    var delegate: TextFieldDelegate?
  
    func textFieldName(name: String) {
        textField.text = name
    }

    
}
