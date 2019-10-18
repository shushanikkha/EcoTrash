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
    
    var users = [User]()

    var locations = [[String: Double]]()
    var ref = DatabaseReference()
    
    typealias StringAny = [String: Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Nefsfeed"
        ref = Database.database().reference()
        loadTrash()
        loadUsers()
    }
    
    private func loadTrash() {
        ref.child("trash").observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for snap in snapshot {
                DispatchQueue.global().async {
                    guard let dict = snap.value as? StringAny else { return }
                    
                    let latitude = dict["latitude"] as! Double
                    let longitude = dict["longitude"] as! Double
                    let creationDate = dict["creationDate"] as! String
                    let availableDate = dict["availableDate"] as! String
                    let type = dict["type"] as! String
                    let amount = dict["amount"] as! Int
                    let address = dict["address"] as! String
                    
                    let userDict = dict["user"] as! StringAny
                    let imagesStr = dict["images"] as! [String]
                    
                    let user = self.parsUser(userDict)
                    var images = [UIImage]()
                    
                    for imageStr in imagesStr {
                        if let imageData = Data(base64Encoded: imageStr),
                            let image = UIImage(data: imageData) {
                            images.append(image)
                        }
                    }
                    
                    let locDict = ["latitude": latitude, "longitude": longitude]
                    let trash = Trash(latitude: latitude, longitude: longitude, creationDate: creationDate, availableDate: availableDate, user: user, type: type, images: images, amount: amount, address: address)
                    
                    self.locations.append(locDict)
                    
                    self.trashes.append(trash)
                    self.sortByDate()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
        return dateFormatter
    }()
    
    func sortByDate() {
        var sorted = trashes
        sorted.sort { trash1, trash2 in
            guard let firstDate = dateFormatter.date(from: trash1.creationDate),
                let secondDate = dateFormatter.date(from: trash2.creationDate) else { return false }
            
            return firstDate < secondDate
        }
        trashes = sorted
    }
    
    func parsUser(_ userDict: StringAny) -> User {
        let firstName = userDict["firstName"] as! String
        let lastName = userDict["lastName"] as! String
        let email = userDict["email"] as! String
        let phoneNumber = userDict["phoneNumber"] as! String
        let id = userDict["id"] as! String
        
        return User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: id)
    }
    
    func loadUsers() {
        self.ref.child("users").observe(.value) { (snapshot) in
            DispatchQueue.main.async {
                guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
                
                for snap in snapshot {
                    guard let userDict = snap.value as? StringAny else { return }
                    
                    let user = self.parsUser(userDict)
                    self.users.append(user)
                }
            }
        }
    }
    
    func getUserId() -> String? {
        guard let mail = UserDefaults.standard.object(forKey: "mail") as? String else { return nil }
        
        for user in users {
            if user.email == mail {
                return user.id
            }
        }
        return nil
    }
    
    @IBAction func myAction(_ sender: UIBarButtonItem) {
        guard let id = getUserId() else { return }
        
        print("trashes.count: ", trashes.count)
        print("getUserId: ", id)
        
        var index = 0
        for trash in trashes {
            print("user id: ", trash.user.id)
            if trash.user.id != id {
                trashes.remove(at: index)
                index -= 1
            }
            index += 1
        }
        tableView.reloadData()
    }
    
    @IBAction func allAction(_ sender: UIBarButtonItem) {
        print(trashes)
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
        guard let newsfeedDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsfeedDetailsViewController") as? NewsfeedDetailsViewController else { return }
        newsfeedDetailsVC.trash = trashes[indexPath.row]
        
        let navVC = UINavigationController(rootViewController: newsfeedDetailsVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    // MARK: - Table view delegate

    @objc func tapGesturTapped() {
        guard let locMapVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationsMapViewController") as? LocationsMapViewController else { return }

        locMapVC.trashes = self.trashes
        let navVC = UINavigationController(rootViewController: locMapVC)
        self.present(navVC, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let locMapView = Bundle.main.loadNibNamed("LocationMapView", owner: self, options: nil)?.first as? LocationMapView else { return UIView()}
        
        locMapView.tapGesture.addTarget(self, action: #selector(tapGesturTapped))
        locMapView.setLocation(locations: locations)
        return locMapView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

