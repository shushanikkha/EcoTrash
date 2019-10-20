//
//  LocationsMapViewController.swift
//  EcoTrash
//
//  Created by Admin on 10/5/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import MapKit

class LocationsMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
//    var regionInMeters: Double = 10000
    var trashes: [Trash]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setLocations()
    }
    
    func setLocations() {
        setRegion()
        guard let trashes = trashes else { return }
        
        var index = 0
        for trash in trashes {
            let location = CLLocationCoordinate2D(latitude: trash.latitude, longitude: trash.longitude)
            let pin = CustomPin(title: trash.address, subTitle: trash.creationDate, location: location, tag: index)
            index += 1
            mapView.addAnnotation(pin)
        }
    }
    
    func setRegion() {
        let regionInMeters: Double = 10000
        let location = CLLocationCoordinate2D(latitude: 40.1872, longitude: 44.5152)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let pin = view.annotation as? CustomPin, let trashes = trashes else { return }
        guard let newsfeedDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsfeedDetailsViewController") as? NewsfeedDetailsViewController else { return }
                newsfeedDetailsVC.trash = trashes[pin.tag]
        
        let navVC = UINavigationController(rootViewController: newsfeedDetailsVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let pin = annotation as? CustomPin else { return nil }
        
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: pin, reuseIdentifier: identifier)
        } else {
            annotationView!.annotation = annotation
        }
        annotationView?.canShowCallout = true
        let pinImage = UIImage(named: "locPin")
        annotationView?.image = pinImage
        
        return annotationView
    }
    
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

