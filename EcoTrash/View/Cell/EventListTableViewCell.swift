//
//  EventListTableViewCell.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/4/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import SDWebImage

class EventListTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    
    func updateEventList(with event: Event) {
        self.eventName.text = event.name
        self.eventDate.text = event.date
        
        if let imageUrl = event.imageUrl {
            self.eventImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }

}
