//
//  RestaurantDetailViewController.swift
//  Closr
//
//  Created by Tao on 2017-02-22.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class RestaurantDetailViewController: UIViewController {

    fileprivate var restaurant: YelpPlace? {
        didSet {
            tableView.reloadData()
        }
    }
    
    enum Section: Int {
        
        static let count = 3
        
        case imageCarousel
        case description
        case event
    }
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                                       = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource                                = self
        tableView.estimatedRowHeight                        = 200
        tableView.rowHeight                                 = UITableViewAutomaticDimension
        
        tableView.register(RestaurantDetailImageCell.self, forCellReuseIdentifier: RestaurantDetailImageCell.reuseIdentifier)
        tableView.register(RestaurantDetailDescriptionCell.self, forCellReuseIdentifier: RestaurantDetailDescriptionCell.reuseIdentifier)
        tableView.register(RestaurantDetailEventCell.self, forCellReuseIdentifier: RestaurantDetailEventCell.reuseIdentifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView <- Edges()
    }

}

extension RestaurantDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let section = Section(rawValue: section) {
            switch section {
            case .event: return 0
            default: return 1
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let section = Section(rawValue: indexPath.section) {
            switch section {
            case .imageCarousel:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailImageCell.reuseIdentifier, for: indexPath) as! RestaurantDetailImageCell
                cell.dataSource = self
                
                cell.loadImages()
                
                return cell
            case .event:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailEventCell.reuseIdentifier, for: indexPath) as! RestaurantDetailEventCell
                
                return cell
            case .description:
                let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailDescriptionCell.reuseIdentifier, for: indexPath) as! RestaurantDetailDescriptionCell
                
                if let restaurant = restaurant {
                    cell.update(restaurant: restaurant)
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == Section.event.rawValue {
            return "Current Event"
        }
        
        return nil
    }
}

extension RestaurantDetailViewController: RestaurantDetailImageCellDataSource {
    func imageURLStringFor(cell: RestaurantDetailImageCell) -> [String] {
        
        return []
    }
}
