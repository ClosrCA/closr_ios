//
//  EventListViewController.swift
//  Closr
//
//  Created by Yale的Mac on 2017/6/28.
//  Copyright © 2017年 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class JoinEventListViewController: UIViewController {
    
    
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
        
        tableView <- Edges()
        
        tableView.reloadData()
    }
    
}

extension JoinEventListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // TODO: replace when model up
        
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: JoinEventTableViewCell.reuseIdentifier,for:indexPath) as! JoinEventTableViewCell
        
        return cell
    }
    
      
}
