//
//  EventListController.swift
//  EcoTrash
//
//  Created by Admin on 9/6/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage


class EventListController: UITableViewController {
    
    private var events = [Event]()
    private var sortedEvents = [[Event]]()
    private var dateArray: [String] = []
    private var convertedArray: [Date] = []
    
    var ref: DatabaseReference?
    var hendler: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        loadDada()
    }
    
    private func loadDada() {
        ref?.child("events").observeSingleEvent(of: DataEventType.value, with: { [weak self] (snapshot) in
            guard let self = self, let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for snap in snapshot {
                guard let dictionary = snap.value as? [String: Any] else { return }
                
                let name = dictionary["name"] as! String
                let address = dictionary["address"] as! String
                let description = dictionary["description"] as! String
                let phone = dictionary["phone"] as! String
                let registrationLink = dictionary["registrationLink"] as! String
                let date = dictionary["date"] as! String
                let image = dictionary["imageUrl"] as! String
                
                var imageUrl: URL?
                
                if image != "" {
                    guard let url = URL(string: image) else { return }
                    imageUrl = url
                }
                
                let event = Event(imageUrl: imageUrl, name: name, description: description, phone: phone, address: address, date: date, registrationLink: registrationLink)
                
                self.events.append(event)
                self.dateArray.append(date)
                            }
            self.sortAndUpdateEvents()
        })
    }
    
    private func sortAndUpdateEvents() {
        sortedEvents = [events]//sortEventsByDate(events: events)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        let header = view as! UITableViewHeaderFooterView
    //        header.textLabel?.textColor = UIColor.black
    //        header.textLabel?.font = UIFont(name: "ԳԱԼԻՔ ՄԻՋՈՑԱՌՈՒՄՆԵՐ", size: 38)!
    //        if  header.textLabel?.text == "ԳԱԼԻՔ ՄԻՋՈՑԱՌՈՒՄՆԵՐ" {
    //            return upcomingEvents.count
    //        } else if header.textLabel?.text == "ԱՆՑԱԾ ԻՐԱԴԱՐՁՈՒԹՅՈՒՆՆԵՐ" {
    //            return pastEvents.count
    //        }
    //        return 1
    //    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedEvents.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedEvents[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = sortedEvents[indexPath.section][indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableViewCell", for: indexPath) as? EventListTableViewCell else { return UITableViewCell() }
        cell.updateEventList(with: event)
        return cell
    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard sortedEvents.count > 1 else { return nil }
//
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        guard sortedEvents.count > 1 else { return .zero }
//
//    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let eventDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "EventListDetailsViewController") as? EventListDetailsViewController else { return }
        eventDetailsVC.event = sortedEvents[0][indexPath.row]
        let navVC = UINavigationController(rootViewController: eventDetailsVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM, yyyy"
        return dateFormatter
    }()
    
    private func sortEventsByDate(events: [Event]) -> [[Event]] {
        var previous = [Event]()
        var after = [Event]()
        events.forEach { event in
            if let date = dateFormatter.date(from: event.date) {
                if date > Date() {
                    previous.append(event)
                } else {
                    after.append(event)
                }
            }
        }
        return [previous, after]
    }
}
