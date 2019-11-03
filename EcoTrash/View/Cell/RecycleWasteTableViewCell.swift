//
//  RecycleWasteTableViewCell.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/13/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import SDWebImage

class RecycleWasteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recycleWasteImageView: UIImageView!
    @IBOutlet weak var recycleWasteName: UILabel!
    @IBOutlet weak var recycleWasteResult: UILabel! // yes or no
    
    func updateRecycleWaste(with waste: RecycleWaste) {
        self.recycleWasteName.text = waste.name
        self.recycleWasteResult.text = waste.recycle
        
        if let imageUrl = waste.imageUrl {
            self.recycleWasteImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }

}
