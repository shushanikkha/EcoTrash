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
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var addresLabel: UILabel!
    
    let locetionManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    typealias completionHandler = [String: Any]
    var setAddres: ((completionHandler) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chackLocationServices()
    }
    
    private func setupLocationManager() {
        mapView.delegate = self
        locetionManager.delegate = self
        locetionManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func centerViewOnUserLocation() {
        guard let location = locetionManager.location?.coordinate else { return }
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
    }

    private func chackLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else { return }
            setupLocationManager()
            chackLocationAuthorisation()
            locetionManager.startUpdatingLocation()
            startTackingUserLocation()
    }
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locetionManager.startUpdatingLocation()
        previousLocation = getCenterLocation(mapView: mapView)
    }
    
    private func getCenterLocation(mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    private func chackLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
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
    
    @IBAction func doneAction(_ sender: Any) {
        guard let latitude = previousLocation?.coordinate.latitude,
            let longitude = previousLocation?.coordinate.longitude  else { return }
        
        let dict = ["addres": addresLabel.text!, "latitude": latitude, "longitude": longitude ] as completionHandler
        guard let setAddres = setAddres else { return }
        
        setAddres(dict)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
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
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation, center.distance(from: previousLocation) > 50 else { return }
        
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemark, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: error
                return
            }
            
            guard let placemark = placemark?.first else { return }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.addresLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }
    
}
