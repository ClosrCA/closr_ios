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

class RestaurantListViewController: UIViewController {
    
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView()
        tableView.delegate              = self
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 200
        tableView.rowHeight             = UITableViewAutomaticDimension
        
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.reuseIdentifier)
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.reuseIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.update(restaurant: restaurants[indexPath.row], placeHolder: nil, promoted: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController    = RestaurantDetailViewController(placeID: restaurants[indexPath.row].placeID)
        detailController.search = placeSearch
        
        navigationController?.pushViewController(detailController, animated: true)
    }
}



