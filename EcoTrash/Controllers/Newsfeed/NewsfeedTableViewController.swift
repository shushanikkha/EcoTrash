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
    var changedTreshes = [Trash]()
    var locations = [[String: Double]]()
    var showOnlyMy: Bool = false
    var ref = DatabaseReference()
    
    typealias StringAny = [String: Any]
    
    var user: User {
        guard let userDict = UserDefaults.standard.dictionary(forKey: "userDict") else { return User() }
        
        let firstName = userDict["firstName"] as! String
        let lastName = userDict["lastName"] as! String
        let email = userDict["email"] as! String
        let phoneNumber = userDict["phoneNumber"] as! String
        let id = userDict["id"] as! String
        return User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: id)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "ԹԱՓՈՆՆԵՐ"
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kTabBarHeight, right: 0)
        ref = Database.database().reference()
        loadTrash()
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
                    let id = dict["id"] as! String
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
                    
                    let trash = Trash(latitude: latitude, longitude: longitude, creationDate: creationDate, availableDate: availableDate, user: user, type: type, images: images, amount: amount, address: address, id: id)
                    
                    DispatchQueue.main.async {
                        self.trashes.append(trash)
                        self.updateTrashes()
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
    
    func updateTrashes() {
        var trashes = sortByDate(self.trashes)
        if showOnlyMy {
            trashes = trashes.filter { $0.user.id == self.user.id }
        }
        changedTreshes = trashes
        locations = getLocations(changedTreshes)
        tableView.reloadData()
    }
    
    func getLocations(_ trashes: [Trash]) -> [[String: Double]] {
        var locations = [[String: Double]]()
        trashes.forEach { (trash) in
            let locDict = ["latitude": trash.latitude, "longitude": trash.longitude]
            locations.append(locDict)
        }
        return locations
    }
    
    func sortByDate(_ trashes: [Trash]) -> [Trash] {
        var sorted = trashes
        sorted.sort { trash1, trash2 in
            guard let firstDate = dateFormatter.date(from: trash1.creationDate),
                let secondDate = dateFormatter.date(from: trash2.creationDate) else { return false }
            
            return firstDate > secondDate
        }
        return sorted
    }
    
    func parsUser(_ userDict: StringAny) -> User {
        let firstName = userDict["firstName"] as! String
        let lastName = userDict["lastName"] as! String
        let email = userDict["email"] as! String
        let phoneNumber = userDict["phoneNumber"] as! String
        let id = userDict["id"] as! String
        
        return User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: id)
    }
    
    @IBAction func myAction(_ sender: UIBarButtonItem) {
        showOnlyMy.toggle()
        sender.title = showOnlyMy ? "All" : "My"
        updateTrashes()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changedTreshes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsfeedTableViewCell") as? NewsfeedTableViewCell else { return UITableViewCell() }
        
        let trash = changedTreshes[indexPath.row]
        cell.setup(with: trash)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsfeedDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsfeedDetailsViewController") as? NewsfeedDetailsViewController else { return }
        newsfeedDetailsVC.trash = changedTreshes[indexPath.row]
        
        let navVC = UINavigationController(rootViewController: newsfeedDetailsVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("Delete")
//        }
//    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if self.changedTreshes[indexPath.row].user.id == self.user.id && showOnlyMy {
            let deletAction = UITableViewRowAction(style: .destructive, title: "Deleteee") { (action, indexPath) in
               
                print(self.trashes.count)
                let id = self.changedTreshes[indexPath.row].id
                let filtered = self.trashes.filter({ (trash) -> Bool in
                    return trash.id != id
                })
                
                print(filtered.count)
                self.trashes = filtered
                
                self.ref.child("trash").child(self.changedTreshes[indexPath.row].id).setValue(nil)
                self.changedTreshes.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
//                self.updateTrashes()
            }
            return [deletAction]
        }
        return nil
    }
    
    @objc func tapGesturTapped() {
        guard let locMapVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationsMapViewController") as? LocationsMapViewController else { return }

        locMapVC.trashes = self.changedTreshes
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return showOnlyMy
    }
}

