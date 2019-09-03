//
//  ViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/1/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    var textField: TextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let textField = Bundle.main.loadNibNamed("TextField", owner: self, options: nil)?.first as? TextField {
            stackView.addSubview(textField)
//            textField.delegate = self
        }
        
    }
    

}

