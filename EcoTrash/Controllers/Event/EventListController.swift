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
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kTabBarHeight, right: 0)
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
                let time = dictionary["time"] as! String
                let image = dictionary["imageUrl"] as! String
                
                var imageUrl: URL?
                
                if image != "" {
                    guard let url = URL(string: image) else { return }
                    imageUrl = url
                }
                
                let event = Event(imageUrl: imageUrl, name: name, description: description, phone: phone, address: address, date: date, time: time, registrationLink: registrationLink)
                
                self.events.append(event)
                self.dateArray.append(date)
            }
            self.sortAndUpdateEvents()
        })
    }
    
    private func sortAndUpdateEvents() {
        sortedEvents = self.sortEventsByDate(events: self.events)
        tableView.reloadData()
    }

    // MARK: - Table view data source
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

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 152.0/255.0, green: 186.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        label.text = titleForSection(section)
        
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let eventDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "EventListDetailsViewController") as? EventListDetailsViewController else { return }
        eventDetailsVC.event = sortedEvents[indexPath.section][indexPath.row]
        let navVC = UINavigationController(rootViewController: eventDetailsVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    private func titleForSection(_ section: Int) -> String {
        return section == 0 ? "Գալիք միջոցառումներ" : "Անցած իրադարձություններ"
    }
    
    private func sortEventsByDate(events: [Event]) -> [[Event]] {
        var previous = [Event]()
        var after = [Event]()
        let events = events.sorted(by: >)
        events.forEach { event in
            if let date = event.formattedDate {
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

extension Event: Comparable {
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.formattedDate?.timeIntervalSinceNow ?? 0 < rhs.formattedDate?.timeIntervalSinceNow ?? 0
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.name == rhs.name
    }
}
