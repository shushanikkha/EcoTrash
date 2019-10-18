//
//  CompanyListDetailsViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/29/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class CompanyListDetailsViewController: UIViewController {
    
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var garbageTypeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBorder()
        setup()
    }
    
  
    
    func setupBorder() {
        nameLabel.layer.cornerRadius = 6.0
        nameLabel.layer.borderWidth = 0.5
        nameLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        addressLabel.layer.cornerRadius = 6.0
        addressLabel.layer.borderWidth = 0.5
        addressLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        phoneLabel.layer.cornerRadius = 6.0
        phoneLabel.layer.borderWidth = 0.5
        phoneLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        emailLabel.layer.cornerRadius = 6.0
        emailLabel.layer.borderWidth = 0.5
        emailLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        garbageTypeLabel.layer.cornerRadius = 6.0
        garbageTypeLabel.layer.borderWidth = 0.5
        garbageTypeLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        descriptionTextView.layer.cornerRadius = 6.0
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
    }

    func setup() {
        guard let company = company else { return }
        nameLabel.text = company.name
        addressLabel.text = company.address
        phoneLabel.text = company.phone
        emailLabel.text = company.email
        garbageTypeLabel.text = company.garbageType
        descriptionTextView.text = company.description
        
        if let imageUrl = company.imageUrl {
            companyImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
