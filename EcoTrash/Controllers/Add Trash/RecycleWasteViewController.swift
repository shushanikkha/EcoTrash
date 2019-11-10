//
//  RecycleWasteViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/13/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class RecycleWasteViewController: UIViewController {
 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var wasteTableView: UITableView!
    
    var recycleWaste = [RecycleWaste]()
    var ref: DatabaseReference?
    var hendler: DatabaseHandle?
    var searchWaste = [RecycleWaste]()
    var searching = false

    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    @objc private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
         wasteTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        ref = Database.database().reference()
        loadDada()
    }
    
    private func loadDada() {
        ref?.child("recycleWasteType").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for snap in snapshot {
                guard let dictionary = snap.value as? [String: Any] else { return }
                
                let name = dictionary["name"] as! String
                let recycle = dictionary["recycle"] as! String
                let imageUrlString = dictionary["imageUrl"] as! String
              
                
                var imageUrl: URL?
                
                if imageUrlString != "" {
                    guard let url = URL(string: imageUrlString) else { return }
                    imageUrl = url
                }
                
                let waste = RecycleWaste(imageUrl: imageUrl, recycleResult: recycle, name: name)
                self.recycleWaste.append(waste)
                self.wasteTableView.reloadData()
            }
        })
    }
    
    
    
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension RecycleWasteViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchWaste.count
        } else {
            return recycleWaste.count
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecycleWasteTableViewCell", for: indexPath) as? RecycleWasteTableViewCell else { return UITableViewCell() }
        if searching {
            let search = searchWaste[indexPath.row]
            cell.updateRecycleWaste(with: search)
        } else {
            let waste = recycleWaste[indexPath.row]
            cell.updateRecycleWaste(with: waste)
        }
        return cell
    }
}

extension RecycleWasteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWaste = recycleWaste.filter {
            $0.name.lowercased().hasPrefix(searchText.lowercased()) ||
            $0.name.lowercased().contains(" " + searchText.lowercased())
        }
        searching = true
        wasteTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        wasteTableView.reloadData()
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}



