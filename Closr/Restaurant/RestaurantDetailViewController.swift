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

    var search: YelpPlaceSearch?
    
    fileprivate var placeID: String
    
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
        tableView.tableFooterView                           = UIView()
        
        tableView.register(RestaurantDetailImageCell.self, forCellReuseIdentifier: RestaurantDetailImageCell.reuseIdentifier)
        tableView.register(RestaurantDetailDescriptionCell.self, forCellReuseIdentifier: RestaurantDetailDescriptionCell.reuseIdentifier)
        tableView.register(RestaurantDetailEventCell.self, forCellReuseIdentifier: RestaurantDetailEventCell.reuseIdentifier)
        
        return tableView
    }()
    
    init(placeID: String) {
        
        self.placeID = placeID
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildUI()
        
        // TODO: Loading indicator
        
        search?.fetch(placeID: placeID, completion: { [weak self] (place, error) in
            if error == nil {
                self?.restaurant = place
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        transitionCoordinator?.animate(alongsideTransition: { [weak self] (context) in
            self?.defaultNavigationBar()
        }, completion: nil)
        
    }
    
    fileprivate func buildUI() {
        
        transparentNavigationBar()
        
        view.addSubview(tableView)
        
        tableView <- Edges(EdgeInsets(top: -44, left: 0, bottom: 0, right: 0))
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
        
        return restaurant?.photos ?? []
    }
}
