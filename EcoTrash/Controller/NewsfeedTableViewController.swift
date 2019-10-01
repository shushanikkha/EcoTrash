//
//  NewsfeedTableViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/21/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController {
    
    
    private var trashes = [Trash]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.trashes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trash = trashes[indexPath.row]
        var reuseIdentifier = "NewsfeedTableViewCell"
        if trash.image != nil {
            reuseIdentifier = "ImageNewsfeedTableViewCell"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NewsfeedTableViewCell else { return UITableViewCell() }
        cell.update(with: trash)
        return cell
    }
    
    

}
