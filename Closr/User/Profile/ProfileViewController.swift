//
//  ProfileViewController.swift
//  Closr
//
//  Created by Zhitao on 2017-02-17.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class ProfileViewController: UIViewController {

    fileprivate lazy var tableView: UITableView = {
        let tableView                   = UITableView()
        tableView.dataSource            = self
        tableView.estimatedRowHeight    = 100
        tableView.rowHeight             = UITableViewAutomaticDimension
        
        tableView.register(EventCollectionTableViewCell.self, forCellReuseIdentifier: EventCollectionTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView <- Edges()
        
        buildNavigationItems()
    }

    fileprivate func buildNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(onSettings))
    }
    
    @objc
    fileprivate func onSettings() {
        
        let settingsViewController = SettingsViewController(style: .grouped)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    enum ProfileSection: Int {
        case profile
        case current
        case history
        case count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = ProfileSection(rawValue: section)!
        
        switch section {
        case .current:
            return 1
        case .history:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = ProfileSection(rawValue: indexPath.section)!
        
        switch section {
        case .current:
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCollectionTableViewCell.reuseIdentifier, for: indexPath) as! EventCollectionTableViewCell
            
            return cell
        case .history:
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCollectionTableViewCell.reuseIdentifier, for: indexPath) as! EventCollectionTableViewCell
            
            cell.isCurrent = false
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let section = ProfileSection(rawValue: section)!
        
        switch section {
        case .current:
            return "My Current Events"
        case .history:
            return "My Event History"
        default:
            return nil
        }
    }
}
