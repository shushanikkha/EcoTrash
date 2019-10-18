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

class NewsfeedDetailsViewController: UIViewController {

    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var newsfeedCollectionView: UICollectionView!
    @IBOutlet weak var newsfeedMapView: MKMapView!
    
    private  var addressView: DetailsLabelView?
    private  var creationDateView: DetailsLabelView?
    private  var availableDateView: DetailsLabelView?
    private  var wasteTypeView: DetailsLabelView?
    private  var amountView: DetailsLabelView?
    
    var trash: Trash?
    var imagesArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailsLabels()
    }
    
    private func setupDetailsLabels() {
         guard let trash = trash else { return }
        let width = Int(UIScreen.main.bounds.size.width) - 20
        let height = 50
        let x = 0
        var y = 100
        if let addressView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !trash.address.isEmpty  {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            addressView.frame = frame
            addressView.detailsLabel.text = "Հասցե"
            addressView.detailsNameLabel.text = trash.address
            detailsStackView.addSubview(addressView)
            self.addressView = addressView
        }
      
        if let creationDateView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !trash.creationDate.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            creationDateView.frame = frame
            creationDateView.detailsLabel.text = "Ստեղծվել է"
            creationDateView.detailsNameLabel.text = trash.creationDate
             detailsStackView.addSubview(creationDateView)
            self.creationDateView = creationDateView
        }
        
        if let availableDateView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !trash.availableDate!.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            availableDateView.frame = frame
            availableDateView.detailsLabel.text = "Հասանելի է"
            availableDateView.detailsNameLabel.text = trash.availableDate
            detailsStackView.addSubview(availableDateView)
            self.availableDateView = availableDateView
        }
        
        if let wasteTypeView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !trash.type.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            wasteTypeView.frame = frame
            wasteTypeView.detailsLabel.text = "Տեսակ"
            wasteTypeView.detailsNameLabel.text = trash.type
              detailsStackView.addSubview(wasteTypeView)
            self.wasteTypeView = wasteTypeView
        }
        
        if let amountView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            amountView.frame = frame
            amountView.detailsLabel.text = "Քանակ"
            amountView.detailsNameLabel.text = "\(trash.amount) կգ"
             detailsStackView.addSubview(amountView)
            self.amountView = amountView
        }
      
    }
    
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}


extension NewsfeedDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsfeedDetailsImageCell", for: indexPath) as? NewsfeedDetailsImageCell
        cell?.setup(with: imagesArray[indexPath.row - 1])
//        if let imageUrl = trash!.image {
//          cell?.newsfeedDetailsImageView.sd_setImage(with: imageUrl, completed: nil)
//        }
        return cell ?? UICollectionViewCell()
    }
    
    
}
