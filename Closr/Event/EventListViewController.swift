//
//  EventTableViewController.swift
//  TableViewTest
//
//  Created by Yale的Mac on 2017/3/9.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit
import EasyPeasy

class EventListViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView()
        tableView.delegate              = self
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 200
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.register(NearbyEventTableViewCell.self, forCellReuseIdentifier: NearbyEventTableViewCell.reuseIdentifier)
        
        tableView.register(EventCollectionTableViewCell.self, forCellReuseIdentifier: EventCollectionTableViewCell.reuseIdentifier)
        
        tableView.register(EventListSectionHeader.self, forHeaderFooterViewReuseIdentifier: EventListSectionHeader.reuseIdentifier)
        
        tableView.sectionHeaderHeight  = EventListConstant.sectionHeaderHeight
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView <- Edges()
        
        tableView.reloadData()
    }
    
}

let sectionRowCount=[1,5]



extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionRowCount[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: EventListSectionHeader.reuseIdentifier) as! EventListSectionHeader
        
        if section == 0 {
            sectionHeader.update(title: "Current Event")
            
        }
        else{
            sectionHeader.update(title: "Nearby Event")
            
        }
        
        return sectionHeader
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let sectionNum=indexPath.section
        
        if sectionNum == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCollectionTableViewCell.reuseIdentifier,for:indexPath)// as! CurrentEventTableViewCell
            
            return cell
            
        }
            
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NearbyEventTableViewCell.reuseIdentifier,for:indexPath)// as! NearbyEventTableViewCell
            
            
            return cell
        }
        
    }
}

