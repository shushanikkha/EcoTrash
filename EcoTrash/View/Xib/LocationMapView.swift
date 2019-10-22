//
//  PinMapView.swift
//  EcoTrash
//
//  Created by Admin on 10/4/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import MapKit


class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subTitle: String?
    var tag: Int
    
    init(title: String?, subTitle: String?, location: CLLocationCoordinate2D, tag: Int = 0) {
        self.title = title
        self.subTitle = subTitle
        self.coordinate = location
        self.tag = tag
    }
}

class LocationMapView: UIView, MKMapViewDelegate {
    
    
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mapView.delegate = self
    }
    
    func setLocation(locations: [[String: Double]]?) {
        guard let locations = locations else { return }
        
        for loc in locations {
            let location = CLLocationCoordinate2D(latitude: loc["latitude"]!, longitude: loc["longitude"]!)
            let pin = CustomPin(title: nil, subTitle: nil, location: location)
            
            mapView.addAnnotation(pin)
        }
        setRegion()
    }
    
    func setRegion() {
        let regionInMeters: Double = 10000
        let location = CLLocationCoordinate2D(latitude: 40.1872, longitude: 44.5152)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "tt")
        annotationView.image = UIImage(named: "locPin")
        return annotationView
    }
    
}
