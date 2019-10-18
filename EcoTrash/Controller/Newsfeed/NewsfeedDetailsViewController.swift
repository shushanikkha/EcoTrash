//
//  NewsfeedDetailsViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/4/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import SDWebImage

class NewsfeedDetailsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var newsfeedCollectionView: UICollectionView!
    @IBOutlet weak var newsfeedMapView: MKMapView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private  var addressView: DetailsLabelView?
    private  var creationDateView: DetailsLabelView?
    private  var availableDateView: DetailsLabelView?
    private  var wasteTypeView: DetailsLabelView?
    private  var amountView: DetailsLabelView?
    
    var trash: Trash?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        
        newsfeedCollectionView.delegate = self
        newsfeedCollectionView.dataSource = self
        
        newsfeedMapView.delegate = self

        setupDetailsLabels()
        setLocation()
        newsfeedCollectionView.reloadData()
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func setupDetailsLabels() {
         guard let trash = trash else { return }
        let width = UIScreen.main.bounds.size.width - 20
        if let addressView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView {
            detailsStackView.addSubview(addressView)
            let frame = CGRect(x: 0, y: 100, width: width, height: 50)
            addressView.frame = frame
            self.addressView = addressView
        }
        addressView?.detailsLabel.text = "Հասցե"
        addressView?.detailsNameLabel.text = trash.address
        
        
        if let creationDateView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView {
            detailsStackView.addSubview(creationDateView)
            let frame = CGRect(x: 0, y: 170, width: width, height: 50)
            creationDateView.frame = frame
            self.creationDateView = creationDateView
        }
        creationDateView?.detailsLabel.text = "Ստեղծվել է"
        creationDateView?.detailsNameLabel.text = trash.creationDate
        
        if let availableDateView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView {
            detailsStackView.addSubview(availableDateView)
            let frame = CGRect(x: 0, y: 240, width: width, height: 50)
            availableDateView.frame = frame
            self.availableDateView = availableDateView
        }
        availableDateView?.detailsLabel.text = "Հասանելի է"
        availableDateView?.detailsNameLabel.text = trash.availableDate
        
        if let wasteTypeView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView {
            detailsStackView.addSubview(wasteTypeView)
            let frame = CGRect(x: 0, y: 310, width: width, height: 50)
            wasteTypeView.frame = frame
            self.wasteTypeView = wasteTypeView
        }
        wasteTypeView?.detailsLabel.text = "Տեսակ"
        wasteTypeView?.detailsNameLabel.text = trash.type
        
        if let amountView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView {
            detailsStackView.addSubview(amountView)
            let frame = CGRect(x: 0, y: 380, width: width, height: 50)
            amountView.frame = frame
            self.amountView = amountView
        }
        amountView?.detailsLabel.text = "Քանակ"
        amountView?.detailsNameLabel.text = "\(trash.amount) կգ"
    }
    
    func setLocation() {
        guard let trash = trash else { return }
        
        let location = CLLocationCoordinate2D(latitude: trash.latitude, longitude: trash.longitude)
        let pin = CustomPin(title: nil, subTitle: nil, location: location)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 100000, longitudinalMeters: 100000)
        
        newsfeedMapView.addAnnotation(pin)
        newsfeedMapView.setRegion(region, animated: true)
    }
    
}


extension NewsfeedDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private var images: [UIImage] {
        return trash?.images ?? []
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsfeedDetailsImageCell", for: indexPath) as? NewsfeedDetailsImageCell else { return UICollectionViewCell() }
        cell.setup(with: images[indexPath.row])
        return cell
    }
}
