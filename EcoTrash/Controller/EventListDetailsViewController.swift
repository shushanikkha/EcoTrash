//
//  EventListDetailsViewController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/3/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class EventListDetailsViewController: UIViewController {
    
    @IBOutlet weak var eventImageView: UIImageView!
//    @IBOutlet weak var eventNameLabel: UILabel!
//    @IBOutlet weak var eventAddressLabel: UILabel!
//    @IBOutlet weak var eventDateLabel: UILabel!
//    @IBOutlet weak var eventPhoneLabel: UILabel!
//    @IBOutlet weak var eventRegistrationLinkLabel: UILabel!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    var event: Event?
    private var eventNameView: DetailsLabelView?
    private var eventAddressView: DetailsLabelView?
    private var eventPhoneNumberView: DetailsLabelView?
    private var eventRegistrationLinkView: DetailsLabelView?
    private var eventDateView: DetailsLabelView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextViewBorder()
        setupEvents()
    }

    
    private  func descriptionTextViewBorder() {
//        eventNameLabel.layer.cornerRadius = 6.0
//        eventNameLabel.layer.borderWidth = 0.5
//        eventNameLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
//        eventAddressLabel.layer.cornerRadius = 6.0
//        eventAddressLabel.layer.borderWidth = 0.5
//        eventAddressLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
//        eventPhoneLabel.layer.cornerRadius = 6.0
//        eventPhoneLabel.layer.borderWidth = 0.5
//        eventPhoneLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
//        eventRegistrationLinkLabel.layer.cornerRadius = 6.0
//        eventRegistrationLinkLabel.layer.borderWidth = 0.5
//        eventRegistrationLinkLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
//        eventDateLabel.layer.cornerRadius = 6.0
//        eventDateLabel.layer.borderWidth = 0.5
//        eventDateLabel.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        eventDescriptionTextView.layer.cornerRadius = 6.0
        eventDescriptionTextView.layer.borderWidth = 0.5
        eventDescriptionTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        
    }
    
    func setupEvents() {
        guard let event = event else { return }
//        eventNameLabel.text = event.name
//        eventAddressLabel.text = event.address
//        eventDateLabel.text = event.date
//        eventPhoneLabel.text = event.phone
//        eventRegistrationLinkLabel.text = event.registrationLink
        let width = Int(UIScreen.main.bounds.size.width) - 20
        let height = 70
        let x = 0
        var y = 20
        if let eventNameView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !event.name.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            eventNameView.frame = frame
            eventNameView.detailsLabel.text = "Անվանում"
            eventNameView.detailsNameLabel.text = event.name
            mainStackView.addSubview(eventNameView)
            self.eventNameView = eventNameView
        }
        
        if let eventAddressView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !event.address.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            eventAddressView.frame = frame
            eventAddressView.detailsLabel.text = "Հասցե"
            eventAddressView.detailsNameLabel.text = event.address
            mainStackView.addSubview(eventAddressView)
            self.eventAddressView = eventAddressView
        }
       
       
        
        if let eventPhoneNumberView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !event.phone.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            eventPhoneNumberView.frame = frame
            eventPhoneNumberView.detailsLabel.text = "Հեռախոսահամար"
            eventPhoneNumberView.detailsNameLabel.text = event.phone
            mainStackView.addSubview(eventPhoneNumberView)
            self.eventPhoneNumberView = eventPhoneNumberView
        }
        
        if let eventRegistrationLinkView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !event.registrationLink.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            eventRegistrationLinkView.frame = frame
            eventRegistrationLinkView.detailsLabel.text = "Գրանցում"
            eventRegistrationLinkView.detailsNameLabel.text = event.registrationLink
            mainStackView.addSubview(eventRegistrationLinkView)
            self.eventRegistrationLinkView = eventRegistrationLinkView
        }

        if let eventDateView = Bundle.main.loadNibNamed("DetailsLabelView", owner: self, options: nil)?.first as? DetailsLabelView, !event.date.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            y += height
            eventDateView.frame = frame
            eventDateView.detailsLabel.text = "Ամսաթիվ"
            eventDateView.detailsNameLabel.text = event.date
            mainStackView.addSubview(eventDateView)
            self.eventDateView = eventDateView
        }
        
        eventDescriptionTextView.text = event.description
        if let imageUrl = event.imageUrl {
            eventImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
