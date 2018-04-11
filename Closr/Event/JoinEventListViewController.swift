//
//  EventListViewController.swift
//  Closr
//
//  Created by Yale的Mac on 2017/6/28.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy
import SwaggerClient
import CoreLocation

class JoinEventListViewController: UIViewController {
    
    fileprivate var events: [Event]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView()
        tableView.delegate              = self
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 200
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.separatorStyle        = .none
        
        tableView.register(JoinEventTableViewCell.self, forCellReuseIdentifier: JoinEventTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.easy.layout(Edges())
        
        loadEvents()
    }
    
    fileprivate func loadEvents() {
        LoadingController.startLoadingOn(self)
        
        EventAPI.getEvents(page: 1, pageSize: 20, radius: CLLocationDistance.longDistance) { [weak self] (response, error) in
            
            LoadingController.stopLoading()
            
            guard error == nil else {
                return
            }
            
            self?.events = response?.events
        }
    }
}

extension JoinEventListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: JoinEventTableViewCell.reuseIdentifier,for:indexPath) as! JoinEventTableViewCell
        
        if let event = events?[indexPath.row] {
            cell.update(with: event)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let event = events?[indexPath.row] else { return }
        
        let detailViewController                        = EventDetailViewController(event: event)
        detailViewController.hidesBottomBarWhenPushed   = true
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

