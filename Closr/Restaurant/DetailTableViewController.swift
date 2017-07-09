//
//  DetailTableViewController.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-07-09.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

protocol DetailTableViewControllerDataSource {
    func restaurantOfDetail(controller: DetailTableViewController) -> YelpPlace?
}

class DetailTableViewController: UIViewController {
    
    var dataSource: DetailTableViewControllerDataSource?
    
    lazy var tableView: UITableView = {
        
        let tableView                   = UITableView()
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 200
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.allowsSelection       = false
        tableView.tableFooterView       = UIView()
        
        tableView.register(RestaurantDetailDescriptionCell.self, forCellReuseIdentifier: RestaurantDetailDescriptionCell.reuseIdentifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView <- Edges()
    }

    func reload() {
        tableView.reloadData()
    }
}

extension DetailTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailDescriptionCell.reuseIdentifier, for: indexPath) as! RestaurantDetailDescriptionCell
        
        if let restaurant = dataSource?.restaurantOfDetail(controller: self) {
            cell.update(restaurant: restaurant)
        }
        
        return cell
    }
}
