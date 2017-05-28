//
//  RestaurantListViewController.swift
//  Closr
//
//  Created by Yale的Mac on 2017/2/27.
//  Copyright © 2017年 YaleMac. All rights reserved.
//

import UIKit
import CoreLocation
import EasyPeasy

enum RestaurantListSection: Int {
    case category
    case restaurant
    case count
}

class RestaurantListViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView()
        tableView.delegate              = self
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 200
        tableView.rowHeight             = UITableViewAutomaticDimension
        
        tableView.estimatedSectionHeaderHeight  = 40
        tableView.sectionHeaderHeight           = UITableViewAutomaticDimension
        
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.reuseIdentifier)
        tableView.register(CategoryCarouselTableViewCell.self, forCellReuseIdentifier: CategoryCarouselTableViewCell.reuseIdentifier)
        tableView.register(RestaurantListSectionHeader.self, forHeaderFooterViewReuseIdentifier: RestaurantListSectionHeader.reuseIdentifier)
        
        return tableView
    }()
    
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        return refreshControl
    }()
    
    fileprivate var restaurants = [YelpPlace]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var placeSearch: YelpPlaceSearch!
    
    fileprivate lazy var location: Location = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.addSubview(refreshControl)
        
        tableView <- Edges()
        
        reloadData()
    }
    
    @objc
    fileprivate func reloadData() {
        
        refreshControl.beginRefreshing()
        
        location.getCurrentLocation { [unowned self] (location, error) in
            if error != nil {
                // TODO: location error popup
            }
            
            self.refreshControl.endRefreshing()
            
            let searchRequest = PlaceSearchRequest(center: location.coordinate, radius: CLLocationDistance.defaultRadius, type: YelpAPIConsole.PlaceType.food)
            self.placeSearch  = YelpPlaceSearch(searchRequest: searchRequest)
            
            self.placeSearch.placeNearby { [unowned self] (places, error) in
                if let places = places, error == nil {
                    
                    self.restaurants = places
                }
            }
        }
    }
    
}

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return RestaurantListSection.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == RestaurantListSection.category.rawValue {
            return 1
        }
        
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == RestaurantListSection.category.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCarouselTableViewCell.reuseIdentifier, for: indexPath) as! CategoryCarouselTableViewCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.reuseIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.update(restaurant: restaurants[indexPath.row], placeHolder: nil, promoted: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RestaurantListSectionHeader.reuseIdentifier) as! RestaurantListSectionHeader
        
        if let section = RestaurantListSection(rawValue: section) {
            switch section {
            case .category:
                header.update(title: "CATEGORIES")
            case .restaurant:
                header.update(accessoryTitle: "Powered by", accessoryImage: UIImage(named: "yelp_logo"))
            default:
                break
            }
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == RestaurantListSection.category.rawValue {
            return
        }
        
        let detailController    = RestaurantDetailViewController(placeID: restaurants[indexPath.row].placeID)
        detailController.search = placeSearch
        
        navigationController?.pushViewController(detailController, animated: true)
    }
}



