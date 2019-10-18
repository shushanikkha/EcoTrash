//
//  RecycleWasteViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/13/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class RecycleWasteViewController: UIViewController, UISearchBarDelegate {
 
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var wasteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
       // wasteTableView.dataSource = self

    }
    

    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
    }
}

//extension RecycleWasteViewController: UITableViewDataSource {
//
//    // MARK: - UITableViewDataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
