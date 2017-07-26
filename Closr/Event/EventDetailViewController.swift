//
//  EventDetailViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-07-26.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    enum EventSection: Int {
        case info
        case attendant
        case purpose
        case gallery
        case map
    }
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                           = UITableView(frame: .zero, style: .grouped)
        tableView.sectionFooterHeight           = 0
        tableView.estimatedSectionHeaderHeight  = 20
        tableView.sectionHeaderHeight           = UITableViewAutomaticDimension
        tableView.estimatedRowHeight            = 80
        tableView.rowHeight                     = UITableViewAutomaticDimension
        
        
        
        return tableView
    }()

}
