//
//  CompanyListController.swift
//  EcoTrash
//
//  Created by Admin on 9/6/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class CompanyListController: UITableViewController {
  
    
    private var companies = [CompanyShortList]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company = companies[indexPath.row]
        let reuseIdentifier = "CompanyListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CompanyListTableViewCell else { return UITableViewCell() }
        cell.updateCompanyList(with: company)
        return cell
    }

}
