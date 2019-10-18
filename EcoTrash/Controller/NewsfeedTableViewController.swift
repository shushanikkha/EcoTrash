//
//  NewsfeedTableViewController.swift
//  EcoTrash
//
//  Created by Admin on 10/3/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewsfeedTableViewController: UITableViewController {
    
    var trashes = [Trash]()
    
    var ref = DatabaseReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Newsfeed"
        
        ref = Database.database().reference()
        loadTrash()
    }
    
    private func loadTrash() {
        ref.child("trash").observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for snap in snapshot {
                guard let dict = snap.value as? [String: Any] else { return }
                
                let latitude = dict["latitude"] as! Double
                let longitude = dict["longitude"] as! Double
                let creationDate = dict["creationDate"] as! String
                let availableDate = dict["availableDate"] as! String
                let type = dict["type"] as! String
                let amount = dict["amount"] as! Int
                let address = dict["address"] as! String
                
                let userDict = dict["user"] as! [String: Any]
                let imagesStr = dict["images"] as! [String]
                
                    //User
                    let firstName = userDict["firstName"] as! String
                    let lastName = userDict["lastName"] as! String
                    let email = userDict["email"] as! String
                    let phoneNumber = userDict["phoneNumber"] as! String
                    let id = userDict["id"] as! String
                
                    let user = User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: id)
                
                var images = [UIImage]()
                
                for imageStr in imagesStr {
                    if let imageData = Data(base64Encoded: imageStr),
                        let image = UIImage(data: imageData) {
                        images.append(image)
                    }
                }
                
                let trash = Trash(latitude: latitude, longitude: longitude, creationDate: creationDate, availableDate: availableDate, user: user, type: type, images: images, amount: amount, address: address)
                self.trashes.append(trash)
            }
            self.tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trashes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsfeedTableViewCell") as? NewsfeedTableViewCell else { return UITableViewCell() }
        
        let trash = trashes[indexPath.row]
        cell.setup(with: trash)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsfeedDetailsViewController") as? NewsfeedDetailsViewController else { return }
            
            let navVC = UINavigationController(rootViewController: mapVC)
            self.present(navVC, animated: true, completion: nil)
    }
    
    @objc func tapGesturTapped() {
        guard let locMapVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationsMapViewController") as? LocationsMapViewController else { return }
        
        let navVC = UINavigationController(rootViewController: locMapVC)
        self.present(navVC, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let mapView = Bundle.main.loadNibNamed("LocationMapView", owner: self, options: nil)?.first as? LocationMapView else { return UIView()}
        
        mapView.tapGesture.addTarget(self, action: #selector(tapGesturTapped))
        //mapView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0).isActive = true
        return mapView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

