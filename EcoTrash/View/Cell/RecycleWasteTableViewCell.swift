//
//  RecycleWasteTableViewCell.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/13/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class RecycleWasteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recycleWasteImageView: UIImageView!
    @IBOutlet weak var recycleWasteName: UILabel!
    @IBOutlet weak var recycleWasteResult: UILabel! // yes or no
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
