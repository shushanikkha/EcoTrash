//
//  CompanyListDetailsViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/29/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class CompanyListDetailsViewController: UIViewController {
    
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var companyPhone: UILabel!
    @IBOutlet weak var companyEmail: UILabel!
    @IBOutlet weak var garbageType: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuoBorder()
    
    }
    func setuoBorder() {
        companyName.layer.cornerRadius = 6.0
        companyName.layer.borderWidth = 0.5
        companyName.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        companyAddress.layer.cornerRadius = 6.0
        companyAddress.layer.borderWidth = 0.5
        companyAddress.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        companyPhone.layer.cornerRadius = 6.0
        companyPhone.layer.borderWidth = 0.5
        companyPhone.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        companyEmail.layer.cornerRadius = 6.0
        companyEmail.layer.borderWidth = 0.5
        companyEmail.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        garbageType.layer.cornerRadius = 6.0
        garbageType.layer.borderWidth = 0.5
        garbageType.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        descriptionTextView.layer.cornerRadius = 6.0
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        
    }
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
