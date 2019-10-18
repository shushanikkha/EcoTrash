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
    @IBOutlet weak var mainStackView: UIStackView!
    
    
    var company: Company?
    private var companyNameView: DetailsLabelView?
    private var companyAddressView: DetailsLabelView?
    private var companyPhoneNumberView: DetailsLabelView?
    private var companyEmail: DetailsLabelView?
    private var companyGarbageType: DetailsLabelView?
    private var companyDescriptionTextView: DetailsTextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCompany()
    }
    
  

    func setupCompany() {
        guard let company = company else { return }
        let width = Int(UIScreen.main.bounds.size.width) - 20
        let height = 70
        let x = 0
        var y = 20
        if let companyNameView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !company.name.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            companyNameView.frame = frame
            companyNameView.detailsLabel.text = "Անվանում"
            companyNameView.detailsNameLabel.text = company.name
            mainStackView.addSubview(companyNameView)
            self.companyNameView = companyNameView
        }
        
        if let companyAddressView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !company.address.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            companyAddressView.frame = frame
            companyAddressView.detailsLabel.text = "Հասցե"
            companyAddressView.detailsNameLabel.text = company.address
            mainStackView.addSubview(companyAddressView)
            self.companyAddressView = companyAddressView
        }
        
        if let companyPhoneNumberView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !company.phone.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            companyPhoneNumberView.frame = frame
            companyPhoneNumberView.detailsLabel.text = "Հեռախոսահամար"
            companyPhoneNumberView.detailsNameLabel.text = company.phone
            mainStackView.addSubview(companyPhoneNumberView)
            self.companyPhoneNumberView = companyPhoneNumberView
        }
        
        if let companyEmail = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !company.email.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            companyEmail.frame = frame
            companyEmail.detailsLabel.text = "Էլ. փոստ"
            companyEmail.detailsNameLabel.text = company.email
            mainStackView.addSubview(companyEmail)
            self.companyEmail = companyEmail
        }
        
        if let companyGarbageType = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !company.garbageType.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            companyGarbageType.frame = frame
            companyGarbageType.detailsLabel.text = "Վերամշակման տեսակ"
            companyGarbageType.detailsNameLabel.text = company.garbageType
            mainStackView.addSubview(companyGarbageType)
            self.companyGarbageType = companyGarbageType
        }
        
        if let companyDescriptionTextView = Bundle.main.loadNibNamed("DetailsTextView", owner: self, options: nil)?.first as? DetailsTextView, !company.description.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: 200)
            companyDescriptionTextView.frame = frame
            companyDescriptionTextView.detailsTextView.text = company.description
            mainStackView.addSubview(companyDescriptionTextView)
            self.companyDescriptionTextView = companyDescriptionTextView
        }

        
        if let imageUrl = company.imageUrl {
            companyImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
