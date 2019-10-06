//
//  LocationsMapViewController.swift
//  EcoTrash
//
//  Created by Admin on 10/5/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit

class LocationsMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let mapView = Bundle.main.loadNibNamed("LocationMapView", owner: self, options: nil)?.first as? LocationMapView else { return }
        mapView.frame = self.view.frame
        view.addSubview(mapView)
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
