//
//  CompanyListController.swift
//  EcoTrash
//
//  Created by Admin on 9/6/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class CompanyListController: UITableViewController {
  
    private var companies = [Company]()
    
    var ref: DatabaseReference?
    var hendler: DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kTabBarHeight, right: 0)
        ref = Database.database().reference()
        loadDada()
    }
    
    private func loadDada() {
        ref?.child("companies").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for snap in snapshot {
                guard let dictionary = snap.value as? [String: Any] else { return }
                
                let name = dictionary["name"] as! String
                let address = dictionary["address"] as! String
                let description = dictionary["description"] as! String
                let phone = dictionary["phone"] as! String
                let email = dictionary["email"] as! String
                let garbageType = dictionary["garbageType"] as! String
                let imageUrlString = dictionary["imageUrl"] as! String
                
                var imageUrl: URL?
                
                if imageUrlString != "" {
                    guard let url = URL(string: imageUrlString) else { return }
                    imageUrl = url
                }
                
                let company = Company(imageUrl: imageUrl, name: name, description: description, email: email, phone: phone, address: address, garbageType: garbageType)
                self.companies.append(company)
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company = companies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyListTableViewCell", for: indexPath) as? CompanyListTableViewCell else { return UITableViewCell() }
        cell.updateCompanyList(with: company)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let companyDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "CompanyListDetailsViewController") as? CompanyListDetailsViewController else { return }
        companyDetailsVC.company = companies[indexPath.row]
        let navVC = UINavigationController(rootViewController: companyDetailsVC)
        self.present(navVC, animated: true, completion: nil)
    }


}
