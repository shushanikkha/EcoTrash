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
    @IBOutlet weak var mainStackView: UIStackView!
    
    var event: Event?
    private var eventNameView: DetailsLabelView?
    private var eventAddressView: DetailsLabelView?
    private var eventPhoneNumberView: DetailsLabelView?
    private var eventRegistrationLinkView: DetailsLabelView?
    private var eventDateView: DetailsLabelView?
    private var eventDescriptionTextView: DetailsTextView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEvents()
    }

    
    func setupEvents() {
        guard let event = event else { return }
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
            eventDateView.detailsLabel.text = "Ամսաթիվ/Ժամ"
            eventDateView.detailsNameLabel.text = event.date + ", " + event.time
            mainStackView.addSubview(eventDateView)
            self.eventDateView = eventDateView
        }
        
        if let eventDescriptionTextView = Bundle.main.loadNibNamed("DetailsTextView", owner: self, options: nil)?.first as? DetailsTextView, !event.description.isEmpty {
            let frame = CGRect(x: x, y: y, width: width, height: 200)
            eventDescriptionTextView.frame = frame
            eventDescriptionTextView.detailsTextView.text = event.description
            mainStackView.addSubview(eventDescriptionTextView)
            self.eventDescriptionTextView = eventDescriptionTextView
        }
        
        if let imageUrl = event.imageUrl {
            eventImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    @IBAction private func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
