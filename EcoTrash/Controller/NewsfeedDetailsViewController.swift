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
        amountView?.detailsNameLabel.text = trash.amount + "  կգ"
        
        
      
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
