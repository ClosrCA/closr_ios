//
//  EventDetailViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-07-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class EventDetailViewController: UIViewController {

    enum EventSection: Int {
        
        static let count = 2
        
        case info
        case attendant
        case purpose
        case gallery
        case map
        
        var header: String {
            switch  self {
            case .info:
                return "Restaurant & Time:"
            case .attendant:
                return "Attending:"
            case .purpose:
                return "Purpose:"
            case .gallery:
                return "Restaurant Photos"
            case .map:
                return "Directions:"
            }
        }
    }
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                           = UITableView(frame: .zero, style: .grouped)
        tableView.delegate                      = self
        tableView.dataSource                    = self
        tableView.sectionFooterHeight           = 0
        tableView.estimatedSectionHeaderHeight  = 20
        tableView.sectionHeaderHeight           = UITableViewAutomaticDimension
        tableView.estimatedRowHeight            = 80
        tableView.rowHeight                     = UITableViewAutomaticDimension
        tableView.allowsSelection               = false
        tableView.separatorStyle                = .none
        tableView.backgroundColor               = .white
        
        tableView.register(TableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: TableViewSectionHeader.reuseIdentifier)
        tableView.register(EventInfoTableViewCell.self, forCellReuseIdentifier: EventInfoTableViewCell.reuseIdentifier)
        tableView.register(EventAttendantTableViewCell.self, forCellReuseIdentifier: EventAttendantTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView <- Edges()
    }
}

extension EventDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return EventSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = EventSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: EventInfoTableViewCell.reuseIdentifier, for: indexPath) as! EventInfoTableViewCell
            cell.update(address: "downtonw Toronto", readableTime: "Event starts in 2 hours")
            
            return cell
        case .attendant:
            let cell = tableView.dequeueReusableCell(withIdentifier: EventAttendantTableViewCell.reuseIdentifier, for: indexPath) as! EventAttendantTableViewCell
            cell.dataSource = self
            cell.load()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = EventSection(rawValue: section) else {
            return nil
        }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewSectionHeader.reuseIdentifier) as! TableViewSectionHeader
        
        header.update(title: section.header)
        
        return header
    }
}

extension EventDetailViewController: EventAttendantTableViewCellDataSource {
    func eventAttendantHost() -> User {
        return User(name: "Chianne", birthday: nil, gender: nil, email: nil, phone: nil, avatar: nil)
    }
    
    func eventAttendantGuests() -> [User] {
        let guest = User(name: "Yale", birthday: nil, gender: nil, email: nil, phone: nil, avatar: nil)
        return [guest]
    }
    
    func capability() -> Int {
        return 4
    }
}
