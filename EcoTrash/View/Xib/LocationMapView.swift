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
    
    init(title: String, subTitle: String, location: CLLocationCoordinate2D) {
        self.title = title
        self.subTitle = subTitle
        self.coordinate = location
    }
}

class LocationMapView: UIView, MKMapViewDelegate {
    
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var mapView: MKMapView!
    
    var locArr: [[String: Double]]!
    
    let latitude = 40.24812337555176
    let longitude = 44.927589187198095
    let location = CLLocationCoordinate2D()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mapView.delegate = self
        
        setLocation()
    }
    
    func setLocation() {
        
        locArr = [["latitude": 40.24812337555176, "longitude": 44.927589187198095], ["latitude": 41.24812337555176, "longitude": 44.927589187198095]]
        
        for loc in locArr {
            let location = CLLocationCoordinate2D(latitude: loc["latitude"]!, longitude: loc["longitude"]!)
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100000, longitudinalMeters: 100000)
            mapView.setRegion(region, animated: true)
            let pin = CustomPin(title: "Title", subTitle: "Sub title", location: location)
            
            mapView.addAnnotation(pin)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(777)
    }

    
    
}
