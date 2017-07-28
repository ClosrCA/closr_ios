//
//  EventTableViewController.swift
//  TableViewTest
//
//  Created by Yale的Mac on 2017/3/9.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit
import EasyPeasy

class ProfileEventListViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView()
        tableView.delegate              = self
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 200
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight   = EventListConstant.sectionHeaderHeight
        
        tableView.register(NearbyEventTableViewCell.self, forCellReuseIdentifier: NearbyEventTableViewCell.reuseIdentifier)
        tableView.register(EventCollectionTableViewCell.self, forCellReuseIdentifier: EventCollectionTableViewCell.reuseIdentifier)
        tableView.register(TableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: TableViewSectionHeader.reuseIdentifier)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView <- Edges()
        
        tableView.reloadData()
    }
    
}

extension ProfileEventListViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum ProfileEventListSection: Int {
        case current
        case nearby
        case count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // TODO: replace when model up
        
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return ProfileEventListSection.count.rawValue
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewSectionHeader.reuseIdentifier) as! TableViewSectionHeader
        
        let section = ProfileEventListSection(rawValue: section)!
        
        switch section {
        case .current:
            sectionHeader.update(title: "Current Event")
        case .nearby:
            sectionHeader.update(title: "Nearby Event")
        default:
            break
        }
        
        return sectionHeader
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let section = ProfileEventListSection(rawValue: indexPath.section)!
        
        switch section {
        case .current:
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCollectionTableViewCell.reuseIdentifier,for:indexPath) as! EventCollectionTableViewCell
            
            return cell
        case .nearby:
            let cell = tableView.dequeueReusableCell(withIdentifier: NearbyEventTableViewCell.reuseIdentifier,for:indexPath) as! NearbyEventTableViewCell
            
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
}

