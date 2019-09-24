//
//  AddTViewController.swift
//  EcoTrash
//
//  Created by Admin on 9/20/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import CoreLocation

class AddTViewController: UIViewController {

    @IBOutlet weak var adresLabel: UILabel!
    
    var latitude: Double?
    var longitude: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    

    @IBAction func mapButtonTapeed(_ sender: UIButton) {
        guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        
        mapVC.setAddres = { (dict) -> () in
            self.adresLabel.text = (dict["addres"] as! String)
            self.latitude = (dict["latitude"] as! Double)
            self.longitude = (dict["longitude"] as! Double)
        }
        
        let navVC = UINavigationController(rootViewController: mapVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    
}
