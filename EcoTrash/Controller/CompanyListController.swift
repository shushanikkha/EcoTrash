//
//  CompanyListController.swift
//  EcoTrash
//
//  Created by Admin on 9/6/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CompanyListController: UITableViewController {
  
    private var companies = [Company]()
    var companyList = [CompanyShortList]()
    var closure: ((UIImage) -> Void)?
    
    var ref: DatabaseReference?
    var hendler: DatabaseHandle?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        loadDada()
        print("companies", companies)
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
                
                var image: UIImage? = nil
                
                if imageUrlString != "" {
                    guard let imageUrl = URL(string: imageUrlString) else { return }
                    
                    //let image = self.downloadImage(from: imageUrl)
                    self.getImage(from: imageUrl) { (data, response, error) in
                        
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.async {
                            image = UIImage(data: data)!
                            if let image = image, let closure = self.closure {
                                closure(image)
                            }
                        }
                    }
                }
                
                let company = Company(image: image, name: name, description: address, email: description, phone: phone, address: email, garbageType: garbageType)
                let companyList = CompanyShortList(name: name, image: image, address: address)
                
                self.companyList.append(companyList)
                self.companies.append(company)
                self.tableView.reloadData()
            }
        })
    }
    
    private func getImage(from url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: complition).resume()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(companyList.count)
        return companyList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let company = companyList[indexPath.row]
//        var reuseIdentifier = "CompanyListTableViewCell"
//        if company.image != nil {
//            reuseIdentifier += "+image"
//        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyListTableViewCell", for: indexPath) as? CompanyListTableViewCell else { return UITableViewCell() }
        cell.updateCompanyList(with: company)
        return cell
    }


}
