//
//  MapViewController.swift
//  EcoTrash
//
//  Created by Admin on 9/8/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locetionManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chackLocationServices()
        print(view.frame.height)
    }
    
    func setupLocationManager() {
        locetionManager.delegate = self
        locetionManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locetionManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func chackLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            chackLocationAuthorisation()
            locetionManager.startUpdatingLocation()
        } else {
            
        }
    }
    
    func chackLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locetionManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            locetionManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }
    
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: mapView)
        let locCoord = mapView.convert(location, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        annotation.title = "Title"
        annotation.subtitle = "Subtitle"
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude:
            location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters:
            regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        chackLocationAuthorisation()
    }
}
