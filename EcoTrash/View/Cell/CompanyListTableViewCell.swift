//
//  CompanyListTableViewCell.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/7/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class CompanyListTableViewCell: UITableViewCell {

    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyAddress: UILabel!
    
    func updateCompanyList(with company: CompanyShortList) {
        self.companyImage.image = company.image
        self.companyName.text = company.name
        self.companyAddress.text = company.address
    }

}
